//
//  BuyNowPopUpViewController.swift
//  NeoStore
//
//  Created by neosoft on 28/02/22.
//

import UIKit

class BuyNowPopUpViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var enterQuantityTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var productDetails: ProductDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        setupProductDetailsInView()
    }

    private func setupUI(){
        self.view.backgroundColor = .appGreyFont.withAlphaComponent(0.25)
        let commonCornerRadius: CGFloat = 7
        
        containerView.layer.cornerRadius = commonCornerRadius
        containerView.backgroundColor = .white
        
        productNameLabel.textAlignment = .center
        productNameLabel.numberOfLines = 0
        productNameLabel.lineBreakMode = .byWordWrapping
        productNameLabel.sizeToFit()
        
        enterQuantityTextfield.layer.borderWidth = 2
        enterQuantityTextfield.layer.borderColor = UIColor.green.cgColor
        enterQuantityTextfield.layer.cornerRadius = commonCornerRadius
        
        submitButton.layer.cornerRadius = commonCornerRadius
    }
    
    private func setupGestures(){
        //        setting up notification for keyboard pop up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        //        setting up notification for keyboard hiding
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.containerView.addGestureRecognizer(dismissKeyboardTap)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissPopUpTap = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        self.view.addGestureRecognizer(dismissPopUpTap)
    }
    
    
    private func setupProductDetailsInView(){
        if let productName = self.productDetails.name{
            self.productNameLabel.text = productName
        }
        
        if let productImageURLString = self.productDetails.productImages?[0].productImages{
            let url = URL(string: productImageURLString)
            self.productImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
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
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }

    @objc func dismissPopUp(){
        self.dismiss(animated: appAnimation, completion: nil)
    }

}
