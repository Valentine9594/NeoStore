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
        self.setupUI()
        self.setupNotificationsAndGestures()
        self.setupNavigationBar(title: "Register", currentViewController: .RegisterViewController, operation: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
//            self.setupNavigationBar()
        self.setupObserver()
    }
    
    private func setupObserver(){
//        function and uses reactive listener and bins with viewmodel to check API status
        self.viewModel.registerStatus.bindAndFire { [weak self] RegisterResult in
            guard self != nil else{ return }
            var alertTitle = ""
            var alertMessage: String? = nil
            var actionTitle = ""
            
            switch RegisterResult{
                case .success:
                    alertTitle = "Registeration Successful!"
                    actionTitle = "OK"
                    self?.callAlert(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: actionTitle)

                case .failure:
                    alertTitle = "Registeration Failed!"
                    alertMessage = "Please try again later..."
                    actionTitle = "Cancel"
                    self?.callAlert(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: actionTitle)
                case .none:
                    break
            }
        }
    }
    
    func callAlert(alertTitle: String, alertMessage: String?, actionTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            var alertAction: UIAlertAction!
            if self.viewModel.registerStatus.value == .success{
                alertAction = UIAlertAction(title: alertTitle, style: .default) { [weak self] _ in
                    self?.navigationController?.popToRootViewController(animated: appAnimation)
                }
            }
            else{
                alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            }
            alert.addAction(alertAction)
            self.present(alert, animated: appAnimation, completion: nil)
        }
    }
    
    private func setupNotificationsAndGestures(){
        //        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        //        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
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
//            registerButton.isEnabled = true
        }
        else{
//            registerButton.isEnabled = false
            agreeTermsAndConditions.isSelected = false
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
//        function that validates all textfields and radio buttons on register button click and sends data to  viewmodel
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, let phoneNoString = phoneNumberTextField.text else{
            print("Error 1: \(String(describing: CustomErrors.NoTextFieldValue.errorDescription))")
            return}
        guard let gender = maleRadioButton.isSelected ? "M" : "F" else{return}
        
//        check if all strings contain ""
        let textfieldStringArray = [firstName, lastName, email, password, confirmPassword, phoneNoString]
        if textfieldStringArray.contains("") {
            callAlert(alertTitle: "Alert!", alertMessage: "Some Textfields are Empty", actionTitle: "OK")
        }
        
//        converting phone number into int with optional binding
        guard let phoneNo = Int(phoneNoString) else{
            if phoneNoString == "" { return }
            print("Error 3: \(String(describing: CustomErrors.CannotConvertPhoneNumberFromStringToNumber.errorDescription))")
            callAlert(alertTitle: "Alert!", alertMessage: "Phone Number entered incorrectly", actionTitle: "OK")
            return }
        
//        managing all strings/textfield values in an object
       let userRegisteredDetails = userDetails(firstname: firstName, lastname: lastName, email: email, password: password, confirmPassword: confirmPassword, gender: gender, phoneNumber: phoneNo)
        
        let isValidationRight = self.viewModel.validateUserRegistration(userRegisterDetals: userRegisteredDetails)
    
//        checking if all validation is true or false
        if isValidationRight{
            self.viewModel.getUserRegisterDetails(userRegisterDetails: userRegisteredDetails)
        }
        else{
            callAlert(alertTitle: "Alert", alertMessage: "Some Textfields are incorrect!", actionTitle: "OK")
        }
        
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
//        registerButton.isEnabled = false
        
    }
}
