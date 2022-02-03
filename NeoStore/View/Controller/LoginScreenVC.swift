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
    var viewModel: LoginViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
//        self.viewmodel = LoginViewModel()

    }
    
    init(viewModel: LoginViewModelType){
        self.viewModel = viewModel
//        super.init(nibName: , bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        if let userName = usernameTF.text, let userPassword = passwordTF.text{
            self.viewModel.userLoggedIn.bindAndFire{
                [weak self] (value) in
                guard let `self` = self else{return}
                if value{
                    print("VALUE")
                    
                }
            }
        }
        else{
            print("NOT OK")
        }

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
    }
}
