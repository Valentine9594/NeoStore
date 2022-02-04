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
    var viewModel: LoginViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: appAnimation)
        self.setupUI()
    }
    
    init(viewModel: LoginViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.LoginScreenVC.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        if let userName = usernameTF.text, let userPassword = passwordTF.text{
            self.viewModel.getUserLogInDetail(userName: userName, userPassword: userPassword)
        }
        else{
            print("NOT OK")
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
        let registerViewController = RegisterViewController(nibName: TotalViewControllers.RegisterScreenVC.rawValue, bundle: nil)
        navigationController?.pushViewController(registerViewController, animated: appAnimation)
    }
    
    private func setupUI(){
//        custom background color
        self.view.backgroundColor  = UIColor.appRed
        
//        setting icon and border in all textfields
        setTextField(textfield: self.usernameTF, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: self.passwordTF, image: UIImage(named: textFieldIcons.passwordIcon.rawValue))
        
//        keeping password field as secure text entry
        self.passwordTF.isSecureTextEntry = true
        
//        login button radius
        self.loginBtn.layer.cornerRadius = 10
        
//        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(clickedForgotPassword))
        self.forgotPassLbl.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(clickedPlusIcon))
        self.plusIcon.addGestureRecognizer(tap3)
    }
}
