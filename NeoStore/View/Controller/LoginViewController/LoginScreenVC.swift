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
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupUI()
    }
    
    init(viewModel: LoginViewModelType){
        self.viewModel = viewModel
        super.init(nibName: "LoginScreenVC", bundle: nil)
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
        print("Clicked Forgot Plus Icon!")
    }
    
    private func setupUI(){
//        custom background color
        self.view.backgroundColor  = UIColor.appRed
        
//        setting icon and border in username textfield
        self.usernameTF.layer.borderColor = UIColor.white.cgColor
        self.usernameTF.layer.borderWidth = 2
        if let personImage = UIImage(named: "username_icon"){
            self.usernameTF.setLeftView(image: personImage)
        }
        
//        setting icon and border in password text field, keeping secure text entry
        self.passwordTF.layer.borderColor = UIColor.white.cgColor
        self.passwordTF.layer.borderWidth = 2
        self.passwordTF.isSecureTextEntry = true
        if let passwordImage = UIImage(named: "password_icon"){
            self.passwordTF.setLeftView(image: passwordImage)
        }
        
//        login button radius
        self.loginBtn.layer.cornerRadius = 10
        
//        gesture to close keyboard on cliking anywhere
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(clickedForgotPassword))
        self.forgotPassLbl.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(clickedPlusIcon))
        self.plusIcon.addGestureRecognizer(tap3)
    }
}
