//
//  ResetPasswordViewController.swift
//  NeoStore
//
//  Created by neosoft on 14/02/22.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var currentPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var confirmNewPasswordTextfield: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var viewModel: ResetPasswordViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupNotificationsAndGestures()
        self.setupNavigationBar()
//            self.setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.setupObservers()
    }
    
    init(viewModel: ResetPasswordViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ResetPasswordViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        setTextField(textfield: currentPasswordTextfield, image: UIImage(named: textFieldIcons.passwordIcon.rawValue))
        setTextField(textfield: newPasswordTextfield, image: UIImage(named: textFieldIcons.openPasswordIcon.rawValue))
        setTextField(textfield: confirmNewPasswordTextfield, image: UIImage(named: textFieldIcons.passwordIcon.rawValue))
        
        currentPasswordTextfield.isSecureTextEntry = true
        newPasswordTextfield.isSecureTextEntry = true
        confirmNewPasswordTextfield.isSecureTextEntry = true
        
        resetPasswordButton.layer.cornerRadius = 7
    }
    
    private func setupNotificationsAndGestures(){
//        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
//        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
        
    }
    
    private func setupObservers(){
        self.viewModel.resetPasswordStatus.bindAndFire { [weak self] resetPasswordResult in
            switch resetPasswordResult{
                case .success:
                    self?.callAlert(alertTitle: "Reset Password Successful", alertMessage: "Password has been reset successfully.", actionTitle: "OK")
                case .failure:
                    self?.callAlert(alertTitle: "Reset Password Failed!", alertMessage: "Could not reset password please try again later.", actionTitle: "OK")
                case .none:
                    break
            }
        }
    }
    
    
    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "Reset Password"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
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
    
    @IBAction func clickedResetPassword(_ sender: UIButton) {
        if let currentPassword = currentPasswordTextfield.text, let newPassword = newPasswordTextfield.text, let confirmPassword = confirmNewPasswordTextfield.text{
 
            let validationResult = self.viewModel.validateResetPasswordDetails(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
            if validationResult{                self.viewModel.getResetPasswordDetails(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
            }
            else{
                callAlert(alertTitle: "Alert!", alertMessage: "Textfields Incorrect or cannot set old password again.", actionTitle: "OK")
            }
        }
        else{
            callAlert(alertTitle: "Alert!", alertMessage: "Some textfields are empty.", actionTitle: "OK")
        }
    }
    
    func callAlert(alertTitle: String, alertMessage: String?, actionTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            var alertAction: UIAlertAction!
            if self.viewModel.resetPasswordStatus.value == .success{
                alertAction = UIAlertAction(title: actionTitle, style: .default) { [weak self] _ in
                    let loginViewModel = LoginViewModel()
                    let loginViewController = LoginScreenVC(viewModel: loginViewModel)
                    self?.navigationController?.pushViewController(loginViewController, animated: appAnimation)
                }
            }
            else{
                alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            }

            alert.addAction(alertAction)
            self.present(alert, animated: appAnimation, completion: nil)
        }
    }
    
}
