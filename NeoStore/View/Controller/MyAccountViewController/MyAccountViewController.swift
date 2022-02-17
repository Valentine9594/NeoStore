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
//    var imagePicker = ImagePicker!
    var imagePicker: ImagePicker!
    var viewModel: MyAccountUpdateViewModelType!
    var canEditTextfields: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNotificationsAndGestures()
        self.setupUI()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        self.navigationController?.isNavigationBarHidden = false
        self.fetchUserDetails()
        self.setupObservers()
    }
    
    init(viewModel: MyAccountUpdateViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.MyAccountViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers(){
        self.viewModel.myAccountUpdateStatus.bindAndFire { MyAccountUpdateResult in
            switch MyAccountUpdateResult{
                case .success:
                    debugPrint("Success Alert")
                    self.callAlert(alertTitle: "Success!", alertMessage: "Your account details have been updated.", actionTitle: "OK")
                case .failure:
                    debugPrint("Failure Alert")
                    self.callAlert(alertTitle: "Error", alertMessage: "There was an error updating your account please try again later.", actionTitle: "OK")
                case .none:
                    break
            }
        }
    }

    private func setupUI(){
        self.becomeFirstResponder()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        if let image = UIImage(named: textFieldIcons.userIcon.rawValue){
            profilImageView.image = image
        }
        profilImageView.layer.cornerRadius = 67
        profilImageView.layer.borderWidth = 2
        profilImageView.layer.borderColor = UIColor.white.cgColor
        profilImageView.isUserInteractionEnabled = true
        
        setTextField(textfield: firstnameTextfield, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: lastnameTextfield, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        setTextField(textfield: emailTextfield, image: UIImage(named: textFieldIcons.emailIcon.rawValue))
        setTextField(textfield: phoneNumberTextfield, image: UIImage(named: textFieldIcons.phoneIcon.rawValue))
        setTextField(textfield: dateOfBirthTextField, image: UIImage(named: textFieldIcons.dobIcon.rawValue))
        
        textfieldsShouldBeEditable(shouldBeEnabled: canEditTextfields)
        
        editProfileButton.setTitle(ButtonTitles.canEdit.description, for: .normal)
        editProfileButton.layer.cornerRadius = 7
    }
    
    private func textfieldsShouldBeEditable(shouldBeEnabled: Bool){
        firstnameTextfield.isEnabled = shouldBeEnabled
        lastnameTextfield.isEnabled = shouldBeEnabled
        emailTextfield.isEnabled = shouldBeEnabled
        phoneNumberTextfield.isEnabled = shouldBeEnabled
        dateOfBirthTextField.isEnabled = shouldBeEnabled
        profilImageView.gestureRecognizers?.first?.isEnabled = shouldBeEnabled
    }
    
    private func setupNotificationsAndGestures(){
//        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
//        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
        
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(clickedProfileImageView))
        self.profilImageView.addGestureRecognizer(profileImageTap)
        
    }
    
    @objc func clickedProfileImageView(){
        self.imagePicker.present(from: self.scrollView)
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
    
    
    @IBAction func clickedEditProfileButton(_ sender: UIButton) {
        
        self.editProfileButton.setTitle(ButtonTitles.saveChanges.description, for: .normal)
        self.canEditTextfields = true
        self.textfieldsShouldBeEditable(shouldBeEnabled: canEditTextfields)
        
        if editProfileButton.currentTitle == ButtonTitles.saveChanges.description{
        let shouldSave = self.myAccountIsEditing()
            
            if shouldSave{
                self.editProfileButton.setTitle(ButtonTitles.canEdit.description, for: .normal)
                self.canEditTextfields = false
                self.textfieldsShouldBeEditable(shouldBeEnabled: canEditTextfields)
            }
        }
                
    }
    
    private func fetchUserDetails(){
        debugPrint("Firstname: \(String(describing: getDataFromUserDefaults(key: .firstname)))")
        debugPrint("Lastname: \(String(describing: getDataFromUserDefaults(key: .lastname)))")
        debugPrint("Email: \(String(describing: getDataFromUserDefaults(key: .email)))")
        debugPrint("Phone Number: \(String(describing: getDataFromUserDefaults(key: .phoneNo)))")
        
        if let firstname = getDataFromUserDefaults(key: .firstname), let lastname = getDataFromUserDefaults(key: .lastname), let email = getDataFromUserDefaults(key: .email), let phoneNo = getDataFromUserDefaults(key: .phoneNo){
            firstnameTextfield.text = firstname
            lastnameTextfield.text = lastname
            emailTextfield.text = email
            phoneNumberTextfield.text = phoneNo
            
            if let dob = getDataFromUserDefaults(key: .dob){
                dateOfBirthTextField.text = dob
            }
            
            if let profileImageString = getDataFromUserDefaults(key: .profilePicture){
                if let imageData = Data(base64Encoded: profileImageString){
                    let profileImage = UIImage(data: imageData)
                    self.profilImageView.image = profileImage
                }
            }
        }
        else{
         callAlert(alertTitle: "Alert!", alertMessage: "Could not fetch account details!", actionTitle: "OK")
        }
    }
    
    private func myAccountIsEditing() -> Bool{
        var profileImageString: String? = nil
        if let profileImage = profilImageView.image{
            profileImageString = convertImageIntoString(image: profileImage)
        }
        
        var dateOfBirth: String? = nil
        if let dob = dateOfBirthTextField.text{
            dateOfBirth = dob
        }
        
        if let firstname = firstnameTextfield.text, let lastname = lastnameTextfield.text, let email = emailTextfield.text, let phoneNo = phoneNumberTextfield.text{
            
            let userNewAccountDetails = userAccountDetails(firstname: firstname, lastname: lastname, profileImage: profileImageString, email: email, dob: dateOfBirth, phoneNo: phoneNo)
            let validationResult = self.viewModel.validateEditMyAccountDetails(userEditAccountDetails: userNewAccountDetails)
            
            if validationResult{
                self.viewModel.getmyAccountUpdateDetails(userEditAccountDetails: userNewAccountDetails)
                return true
            }
        }
        return false
    }
    
    func convertImageIntoString(image: UIImage) -> String?{
        var imageData: Data? = nil
        if let imageDataPng = image.pngData(){
            imageData = imageDataPng
        }
        else if let imageDataJpeg = image.jpegData(compressionQuality: 1){
            imageData = imageDataJpeg
        }
        
        if imageData != nil{
            let imageString = imageData?.base64EncodedString()
            return imageString
        }
        
        return nil
    }
    
    @IBAction func clickedResetPasswordButton(_ sender: UIButton) {
        let resetPasswordViewModel = ResetPasswordViewModel()
        let resetPasswordViewController = ResetPasswordViewController(viewModel: resetPasswordViewModel)
        navigationController?.pushViewController(resetPasswordViewController, animated: appAnimation)
    }
    
    
    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "My Account"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    func callAlert(alertTitle: String, alertMessage: String?, actionTitle: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            var alertAction: UIAlertAction!
            alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: appAnimation, completion: nil)
        }
    }
    

}

extension MyAccountViewController: ImagePickerDelegate, UITextFieldDelegate{
    func didSelect(image: UIImage?) {
        self.profilImageView.image = image
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.canEditTextfields
    }
}
