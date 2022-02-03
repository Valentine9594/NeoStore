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

    private func setupUI(){
        self.view.backgroundColor  = UIColor.appRed
        
        self.usernameTF.layer.borderColor = UIColor.white.cgColor
        self.usernameTF.layer.borderWidth = 2
        
        self.passwordTF.layer.borderColor = UIColor.white.cgColor
        self.passwordTF.layer.borderWidth = 2
        self.passwordTF.isSecureTextEntry = true
        
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
