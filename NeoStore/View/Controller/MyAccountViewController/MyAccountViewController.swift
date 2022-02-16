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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupNotificationsAndGestures()
            self.setupUI()
            self.setupNavigationBar()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
        }
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
        
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(clickedProfileImageView))
        self.profilImageView.addGestureRecognizer(profileImageTap)
        
    }
    
    @objc func clickedProfileImageView(){
        debugPrint("Clicked Profile Image!!!")
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
        self.editProfileButton.setTitle("Save", for: .normal)
        
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
            }
            else{
                debugPrint("Incorrect Alert")
                callAlert(alertTitle: "Alert!", alertMessage: "Some textfields have incorrect values.", actionTitle: "OK")
            }
            
        }else{
            debugPrint("No Text Alert")
            callAlert(alertTitle: "Alert!", alertMessage: "Some textfields are empty please fill them!", actionTitle: "OK")
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

extension MyAccountViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        self.profilImageView.image = image
    }
}
