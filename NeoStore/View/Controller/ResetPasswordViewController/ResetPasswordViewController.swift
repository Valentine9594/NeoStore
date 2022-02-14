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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupUI()
        }
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

    @IBAction func clickedResetPassword(_ sender: UIButton) {
        debugPrint("Clicked Reset Password!!")
    }
    
}
