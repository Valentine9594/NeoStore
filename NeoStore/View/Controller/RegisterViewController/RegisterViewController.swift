//
//  RegisterViewController.swift
//  NeoStore
//
//  Created by neosoft on 04/02/22.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var maleRadioButton: UIButton!
    @IBOutlet weak var femaleRadioButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var agreeTermsAndConditions: UIButton!
    var viewModel: RegisterViewModelType
    
    init(viewModel: RegisterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.RegisterViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupUI()
            self.setupNotificationsAndGestures()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            self.setupNavigationBar()
        }
    }
    
    private func setupNotificationsAndGestures(){
        //        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        //        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
    }
    
    @IBAction func maleRadioButtonSelected(_ sender: UIButton) {
        maleRadioButton.isSelected = true
        femaleRadioButton.isSelected = false
    }
    
    @IBAction func femaleRadioButtonSelected(_ sender: UIButton) {
        femaleRadioButton.isSelected = true
        maleRadioButton.isSelected = false
    }
    
    @IBAction func checkAgreeTermsAndConditions(_ sender: UIButton) {
        if !agreeTermsAndConditions.isSelected{
            agreeTermsAndConditions.isSelected = true
            registerButton.isEnabled = true
        }
        else{
            registerButton.isEnabled = false
            agreeTermsAndConditions.isSelected = false
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
//        function that validates all textfields and radio buttons on register button click and sends data to  viewmodel
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, let phoneNoString = phoneNumberTextField.text else{
            print("Error 1: \(CustomErrors.NoTextFieldValue.description)")
            return}
        guard firstName != "", lastName != "", email != "", password.count >= 8, confirmPassword == password, phoneNoString != "" else{
            print("Error 2: \(CustomErrors.EmptyString.description)")
            return}
        guard let gender = maleRadioButton.isSelected ? "M" : "F" else{return}
        guard let phoneNo = Int(phoneNoString) else{
            print("Error 3: \(CustomErrors.CannotConvertPhoneNumberFromStringToNumber.description)")
            return}

        let userRegistrationDetails = userDetails(firstname: firstName, lastname: lastName, email: email, password: password, confirmPassword: confirmPassword, gender: gender, phoneNumber: phoneNo)
        self.viewModel.getUserRegisterDetails(userRegisterDetails: userRegistrationDetails)
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
        self.scrollView.contentInset.bottom = .zero
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }
    
    private func setupUI(){
        self.view.backgroundColor  = UIColor.appRed
        
//        setting up border color, width and left image in all text fields
        setTextField(textfield: firstNameTextField, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: lastNameTextField, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: emailTextField, image: UIImage(named: textFieldIcons.emailIcon.rawValue))
        setTextField(textfield: passwordTextField, image: UIImage(named: textFieldIcons.openPasswordIcon.rawValue))
        setTextField(textfield: confirmPasswordTextField, image: UIImage(named: textFieldIcons.passwordIcon.rawValue))
        setTextField(textfield: phoneNumberTextField, image: UIImage(named: textFieldIcons.phoneIcon.rawValue))
        
//        setting password and confirm password textfields to secure entry
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
//        setting phone number and email address keyboard type to respective types
        phoneNumberTextField.keyboardType = .phonePad
        emailTextField.keyboardType = .emailAddress
        
        registerButton.layer.cornerRadius = 7
        registerButton.isEnabled = false
        
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.appRed
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = appAnimation
    }

}

//extension RegisterViewController: UITextFieldDelegate{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("typing")
//    }
//}
