//
//  LoginScreenVC.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import UIKit

class LoginScreenVC: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPassLbl: UILabel!
    @IBOutlet weak var plusIcon: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var viewModel: LoginViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            self.setupUI()
            self.setupNotificationsAndGestures()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: appAnimation)
    }
    
    init(viewModel: LoginViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.LoginViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObserver(){
//        function and uses reactive listener and bins with viewmodel to check API status
        self.viewModel.loginStatus.bindAndFire { LoginResult in
            switch LoginResult{
                case .success:
                    debugPrint("Succesfully Logged In.")
                case .failure:
                    let message = "Incorrect Email or Password!"
                    self.callAlert(alertMessage: message)
                case .none:
                    break
            }
        }
    }

    private func callAlert(alertMessage: String?){
        let alert = UIAlertController(title: "Login Failed!", message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            self?.dismiss(animated: appAnimation, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: appAnimation, completion: nil)
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        if let userName = usernameTF.text, let userPassword = passwordTF.text, userName != "", userPassword != ""{
            self.viewModel.getUserLogInDetail(userName: userName, userPassword: userPassword)
        }
        else{
            let message = "Username and Password not entered correctly!"
            callAlert(alertMessage: message)
        }

    }
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }
    
    @objc func clickedForgotPassword(_ sender: UITapGestureRecognizer){
        print("Clicked Forgot Password!")
    }
    
    @objc func clickedPlusIcon(_ sender: UITapGestureRecognizer){
        let registerViewModel = RegisterViewModel()
        let registerViewController = RegisterViewController(viewModel: registerViewModel)
        navigationController?.pushViewController(registerViewController, animated: appAnimation)
    }
    
    private func setupUI(){
//        custom background color
        self.view.backgroundColor  = UIColor.appRed
        
//        setting icon and border in all textfields
        setTextField(textfield: usernameTF, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: passwordTF, image: UIImage(named: textFieldIcons.passwordIcon.rawValue))
        
//        keeping password field as secure text entry
        passwordTF.isSecureTextEntry = true
        
//        login button radius
        loginBtn.layer.cornerRadius = 7
        
    }
    
    private func setupNotificationsAndGestures(){
//        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
//        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
        
//        gesture on clicking forgot label
        let forgotPasswordTap = UITapGestureRecognizer(target: self, action: #selector(clickedForgotPassword))
        forgotPassLbl.addGestureRecognizer(forgotPasswordTap)
        
//        gesture on clicking plus icon for registering
        let plusIconTap = UITapGestureRecognizer(target: self, action: #selector(clickedPlusIcon))
        plusIcon.addGestureRecognizer(plusIconTap)
    }
    
    @objc func keyboardShow(notification: Notification){
//        code to attach keyboard size when keyboard pops up in scrollview
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.scrollView.contentInset.bottom = keyboardHeight
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
    
    @objc func keyboardHide(){
//        code to adjust scrollview to zero after keyboard closing
        self.scrollView.contentInset.bottom = .zero
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
}
