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
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupUI()
            self.setupNotificationsAndGestures()
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
    
    private func setupNotificationsAndGestures(){
//        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
//        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
        
    }
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }

    @objc func keyboardShow(notification: Notification){
//        code to attach keyboard size when keyboard pops up in scrollview
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.scrollView.contentInset.bottom = keyboardHeight
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
    
    @objc func keyboardHide(){
//        code to adjust scrollview to zero after keyboard closing
        self.scrollView.contentInset.bottom = .zero
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
    
    @IBAction func clickedResetPassword(_ sender: UIButton) {
        debugPrint("Clicked Reset Password!!")
    }
    
}
