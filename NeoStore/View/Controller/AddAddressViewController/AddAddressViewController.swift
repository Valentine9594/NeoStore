//
//  AddAddressViewController.swift
//  NeoStore
//
//  Created by neosoft on 08/03/22.
//

import UIKit

class AddAddressViewController: UIViewController {
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var landamarkTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var zipcodeTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveAddressButton: UIButton!
    var viewModel: AddressViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUIandNotificationsAndGestures()
        setupNavigationBar(title: "Add Address", currentViewController: .AddAddressViewController, operation: nil)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    init(viewModel: AddressViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.AddAddressViewController.description, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIandNotificationsAndGestures(){
        saveAddressButton.layer.cornerRadius = 7
        
    //        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    //        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    //        gesture to close keyboard on cliking anywhere
        let dismissInputTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissInputTap)
    }
    
    @IBAction func clickedSaveAddress(_ sender: UIButton) {
        let address = addressTextView.text
        let city = cityTextfield.text
        let state = stateTextfield.text
        let zipcode = zipcodeTextfield.text
        let country = countryTextfield.text
        if self.viewModel.validateAllData(address: address, city: city, state: state, zipcode: zipcode, country: country){
            self.viewModel.saveAddressInUserDefaults(address: address!)
            popToPreviousViewController()
        }else{
            self.callAlert(alertTitle: "Alert!", alertMessage: "Some Textfields are empty.")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
