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
    
    @IBAction func clickedResetPasswordButton(_ sender: UIButton) {
        let resetPasswordVC = ResetPasswordViewController(nibName: TotalViewControllers.ResetPasswordViewController.rawValue, bundle: nil)
        navigationController?.pushViewController(resetPasswordVC, animated: appAnimation)
    }
    

}
