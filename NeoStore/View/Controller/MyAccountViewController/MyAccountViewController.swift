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
    var datePicker: UIDatePicker!
    var imagePicker: ImagePicker!
    var viewModel: MyAccountUpdateViewModelType!
    var canEditTextfields: Bool = false
    var didEditAnything: Bool = false
    var changedProfileImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNotificationsAndGestures()
        self.setupUI()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetViewController()
        self.fetchUserDetails()
        self.setupObservers()
    }
    
    private func resetViewController(){
        self.canEditTextfields = false
        self.didEditAnything = false
        self.viewModel.myAccountUpdateStatus.value = .none
        self.textfieldsShouldBeEditable(shouldBeEnabled: canEditTextfields)
        self.changedProfileImage = false
    }
    
    init(viewModel: MyAccountUpdateViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.MyAccountViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers(){
        self.viewModel.myAccountUpdateStatus.bindAndFire { [weak self] MyAccountUpdateResult in
            switch MyAccountUpdateResult{
                case .success:
                    self?.resetViewController()
                    self?.callAlert(alertTitle: "Success!", alertMessage: "Your account details have been updated.", actionTitle: "OK")
                case .failure:
                    self?.callAlert(alertTitle: "Error", alertMessage: "There was an error updating your account please try again later.", actionTitle: "OK")
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
        profilImageView.layer.cornerRadius = 66
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
        
        self.setupDatepicker()
    }
    
    private func setupDatepicker(){
        DispatchQueue.main.async {
            self.datePicker = UIDatePicker()
            self.datePicker.datePickerMode = .date
            self.datePicker.locale = .current
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.sizeToFit()
            let currentDate = Date()
            self.datePicker.maximumDate = currentDate
            
            let toolBar = UIToolbar()
            toolBar.tintColor = UIColor.appGreyFont
            toolBar.backgroundColor = .white
            toolBar.isTranslucent = appAnimation
            toolBar.sizeToFit()
            
            let titleFontHeight = toolBar.frame.size.height/2.5
            let doneButton = UIBarButtonItem(title: ButtonTitles.done.description, style: .done, target: self, action: #selector(self.dismissDatePicker))
            doneButton.setTitleTextAttributes([.font: UIFont(name: "iCiel Gotham Medium", size: titleFontHeight)!], for: .normal)
            let cancelButton = UIBarButtonItem(title: ButtonTitles.cancel.description, style: .done, target: self, action: #selector(self.cancelDatePicker))
            cancelButton.setTitleTextAttributes([.font: UIFont(name: "iCiel Gotham Medium", size: titleFontHeight)!], for: .normal)
            
            toolBar.setItems([cancelButton, .flexibleSpace(), doneButton], animated: appAnimation)
            toolBar.isUserInteractionEnabled = true
            self.dateOfBirthTextField.inputAccessoryView = toolBar
            self.dateOfBirthTextField.inputView = self.datePicker
        }
    }
    
    private func textfieldsShouldBeEditable(shouldBeEnabled: Bool){
        DispatchQueue.main.async {
            self.firstnameTextfield.isEnabled = shouldBeEnabled
            self.lastnameTextfield.isEnabled = shouldBeEnabled
            self.emailTextfield.isEnabled = shouldBeEnabled
            self.phoneNumberTextfield.isEnabled = shouldBeEnabled
            self.dateOfBirthTextField.isEnabled = shouldBeEnabled
            self.profilImageView.gestureRecognizers?.first?.isEnabled = shouldBeEnabled
        }
    }
    
    @objc func dismissDatePicker(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        dateOfBirthTextField.text = dateString
        
        self.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.resignFirstResponder()
        self.view.endEditing(true)
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
        
        let currentTitle = editProfileButton.currentTitle
    
        if currentTitle == ButtonTitles.canEdit.description{
            self.editProfileButton.setTitle(ButtonTitles.saveChanges.description, for: .normal)
            self.canEditTextfields = true
            self.textfieldsShouldBeEditable(shouldBeEnabled: canEditTextfields)
//            editProfileButton.isSelected = false
        }
        else if currentTitle == ButtonTitles.saveChanges.description{
//            editProfileButton.isSelected = true
            let isAccountEdited = myAccountIsEditing()
            if isAccountEdited{
                self.editProfileButton.setTitle(ButtonTitles.canEdit.description, for: .normal)
                self.canEditTextfields = false
                self.textfieldsShouldBeEditable(shouldBeEnabled: canEditTextfields)
            }
        }
                
    }
        
    private func myAccountIsEditing() -> Bool{
        var profileImageString: String? = nil
        if self.changedProfileImage, let profileImage = profilImageView.image{
            profileImageString = convertImageIntoString(image: profileImage)
        }
//        debugPrint(profileImageString ?? "No Profile Image String!!")
        
        var dobString: String? = nil
        if let dob = dateOfBirthTextField.text{
            dobString = dob
        }
        
        if let firstname = firstnameTextfield.text, let lastname = lastnameTextfield.text, let email = emailTextfield.text, let phoneNo = phoneNumberTextfield.text{
            
            let userNewAccountDetails = userAccountDetails(firstname: firstname, lastname: lastname, profileImage: profileImageString, email: email, dob: dobString, phoneNo: phoneNo)
            let validationResult = self.viewModel.validateEditMyAccountDetails(userEditAccountDetails: userNewAccountDetails)
            
            if validationResult{
                self.viewModel.getmyAccountUpdateDetails(userEditAccountDetails: userNewAccountDetails)
                return true
            }
        }
        return false
    }
    
    private func fetchUserDetails(){
        self.viewModel.fetchUserAccountDetails()
        UserDefaults.standard.setIsProfileUpdated(value: false)
        
//        function to fetch user data. currently with USERDEFAULTS
        DispatchQueue.main.async {
            if let firstname = getDataFromUserDefaults(key: .firstname), let lastname = getDataFromUserDefaults(key: .lastname), let email = getDataFromUserDefaults(key: .email), let phoneNo = getDataFromUserDefaults(key: .phoneNo){
                self.firstnameTextfield.text = firstname
                self.lastnameTextfield.text = lastname
                self.emailTextfield.text = email
                self.phoneNumberTextfield.text = phoneNo
                
                if let dob = getDataFromUserDefaults(key: .dob){
                    self.dateOfBirthTextField.text = dob
                }
                
                if self.changedProfileImage, let profileImageString = getDataFromUserDefaults(key: .profilePicture), profileImageString != ""{
                    if let imageData = Data(base64Encoded: profileImageString){
                        let profileImage = UIImage(data: imageData)
                        self.profilImageView.image = profileImage
                    }
                }
            }
            else{
                self.callAlert(alertTitle: "Alert!", alertMessage: "Could not fetch account details!", actionTitle: "OK")
            }

        }
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
        self.navigationController?.isNavigationBarHidden = false
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
            if self.viewModel.myAccountUpdateStatus.value == .success{
                alertAction = UIAlertAction(title: actionTitle, style: .default){ [weak self] _ in
                    self?.viewDidLoad()
                }
            }
            else{
                alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            }
            alert.addAction(alertAction)
            self.present(alert, animated: appAnimation, completion: nil)
        }
    }
    

}

extension MyAccountViewController: ImagePickerDelegate, UITextFieldDelegate{
    func didSelect(image: UIImage?) {
        self.profilImageView.image = image
        self.changedProfileImage = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.canEditTextfields
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.editProfileButton.currentTitle == ButtonTitles.saveChanges.description{
            didEditAnything = true
        }
        didEditAnything = false
    }
    
}
