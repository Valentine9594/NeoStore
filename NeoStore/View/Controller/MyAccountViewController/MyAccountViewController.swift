//
//  MyAccountViewController.swift
//  NeoStore
//
//  Created by neosoft on 14/02/22.
//

import UIKit

class MyAccountViewController: UIViewController {
    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var resetPasswordTextfield: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupUI()
        }
    }

    private func setupUI(){
        if let image = UIImage(named: textFieldIcons.userIcon.rawValue){
            profilImageView.image = image
        }
        profilImageView.layer.cornerRadius = 67
        profilImageView.layer.borderWidth = 2
        profilImageView.layer.borderColor = UIColor.white.cgColor
        
        setTextField(textfield: firstnameTextfield, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: lastnameTextfield, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: emailTextfield, image: UIImage(named: textFieldIcons.emailIcon.rawValue))
        setTextField(textfield: phoneNumberTextfield, image: UIImage(named: textFieldIcons.phoneIcon.rawValue))
        setTextField(textfield: dateOfBirthTextField, image: UIImage(named: textFieldIcons.dobIcon.rawValue))
        
        
        editProfileButton.layer.cornerRadius = 7
    }
    
    @IBAction func clickedResetPasswordButton(_ sender: UIButton) {
        let resetPasswordVC = ResetPasswordViewController(nibName: TotalViewControllers.ResetPasswordViewController.rawValue, bundle: nil)
        navigationController?.pushViewController(resetPasswordVC, animated: appAnimation)
    }
    

}
