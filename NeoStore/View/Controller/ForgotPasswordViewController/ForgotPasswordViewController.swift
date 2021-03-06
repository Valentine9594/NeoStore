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
        DispatchQueue.main.async {
            self.setupNavigationBar(title: "Forgot Password", currentViewController: .ForgotPasswordViewController, operation: nil)
            self.setupUI()
            self.setupNotificationsAndGestures()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
//            self.setupNavigationBar()
        self.setupObserver()
    }
    
    init(viewModel: ForgotPasswordViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ForgotPasswordViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObserver(){
        self.viewModel.forgotPasswordStatus.bindAndFire { [weak self] Result in
            switch Result{
                case .success:
                    self?.callAlert(alertTitle: "Email Sent", alertMessage: "Please check the email sent to the entered email address.", actionTitle: "OK")
                case .failure:
                    self?.callAlert(alertTitle: "Alert!", alertMessage: "There was an error sending email!", actionTitle: "OK")
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
                alertAction = UIAlertAction(title: actionTitle, style: .default, handler: {[weak self] _ in
                    self?.navigationController?.popToRootViewController(animated: appAnimation)
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
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
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
    
}
