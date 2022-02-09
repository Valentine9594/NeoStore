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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setupUI(){
        self.view.backgroundColor = UIColor.appRed
        
        setTextField(textfield: usernameTextField, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        
        sendButton.layer.cornerRadius = 7
    }

    @IBAction func sendButtonAction(_ sender: UIButton) {
        debugPrint("Clicking Send Button!")
    }
    
}
