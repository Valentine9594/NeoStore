//
//  ForgotPasswordViewController.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var viewModel: ForgotPasswordViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupUI()
        setupNotificationsAndGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            self.setupObserver()
//            self.setupNavigationBar()
        }
    }
    
    init(viewModel: ForgotPasswordViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ForgotPasswordViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObserver(){
        self.viewModel.forgotPasswordStatus.bindAndFire { Result in
            switch Result{
                case .success:
                    self.callAlert(alertTitle: "Email Sent", alertMessage: "Please check the email sent to the entered email address.", actionTitle: "OK")
                case .failure:
                    self.callAlert(alertTitle: "Alert!", alertMessage: "There was an error sending email!", actionTitle: "OK")
                case .none:
                    break
            }
        }
    }
    
    func callAlert(alertTitle: String, alertMessage: String?, actionTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            var alertAction: UIAlertAction
            if self.viewModel.forgotPasswordStatus.value == .success{
                alertAction = UIAlertAction(title: actionTitle, style: .default, handler: {_ in
                    self.navigationController?.popToRootViewController(animated: appAnimation)
                })
            }
            else{
                alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            }

            alert.addAction(alertAction)
            self.present(alert, animated: appAnimation, completion: nil)
        }
    }

    private func setupUI(){
        self.view.backgroundColor = UIColor.appRed
        
        setTextField(textfield: usernameTextField, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        
        sendButton.layer.cornerRadius = 7
    }
    
    private func setupNotificationsAndGestures(){
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
        
    }
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }

    @IBAction func sendButtonAction(_ sender: UIButton) {
        if let username = usernameTextField.text, username != ""{
            self.viewModel.getUserForgotPasswordDetail(userName: username)
        }
        else{
            DispatchQueue.main.async {
                self.callAlert(alertTitle: "Alert!", alertMessage: "Enter email address to receive email to change password.", actionTitle: "OK")
            }
        }

    }
    
    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = self.view.backgroundColor
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "Forgot Password"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
    }

    
}
