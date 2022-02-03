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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

    }

    @IBAction func loginUser(_ sender: UIButton) {
        var loginDict = [String:Any]()
        if let userName = usernameTF.text,let userPassword = passwordTF.text{
            loginDict["email"] = userName
            loginDict["password"] = userPassword
        }

//        let response = UserService.userLogIn(params: loginDict){
//            let data,error in
//            print(data)
//        }
//        print(response)
    }
    
    private func setupUI(){
        self.view.backgroundColor  = UIColor.appRed
        
        self.usernameTF.layer.borderColor = UIColor.white.cgColor
        self.usernameTF.layer.borderWidth = 2
        if let personImage = UIImage(named: "username_icon"){
            self.usernameTF.setLeftView(image: personImage)
        }
        
        self.passwordTF.layer.borderColor = UIColor.white.cgColor
        self.passwordTF.layer.borderWidth = 2
        self.passwordTF.isSecureTextEntry = true
        if let passwordImage = UIImage(named: "password_icon"){
            self.passwordTF.setLeftView(image: passwordImage)
        }
        
        self.loginBtn.layer.cornerRadius = 10
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
