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
    var viewModel: BuyNowViewModelType!
    var productDetails: ProductDetails!
    var isViewAlreadyShifted = false
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterQuantityTextfield.delegate = self
        // Do any additional setup after loading the view.
        setupUI()
        setupGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupProductDetailsInView()
        debugPrint("Access Token: \(String(describing: getDataFromUserDefaults(key: .accessToken)))")
    }
    
    init(viewModel: BuyNowViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.buyNowPopUpViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers(){
        self.viewModel.buyNowRatingResult.bindAndFire { [weak self] result in
            switch result{
                case .success:
                    self?.callAlert(alertTitle: "Success", alertMessage: "Added Product to cart.")
                case .failure(_):
                    let message = "There was an error in adding product to Cart."
                    self?.callAlert(alertTitle: "Alert!", alertMessage: message)
                case .none:
                    debugPrint("None!")
            }
        }
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
        
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.containerView.addGestureRecognizer(dismissKeyboardTap)
        
        //        gesture to close keyboard on cliking anywhere
        let dismissPopUpTap = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        self.view.addGestureRecognizer(dismissPopUpTap)
    }
    
    @IBAction func clickedBuyNowSubmitButton(_ sender: UIButton) {
        guard let productId = self.productDetails.id else{ return }
//        guard let quantity = 3 else{ return }
        guard let quantityText = enterQuantityTextfield.text else{ return }
        if let quantity = Int(quantityText), self.viewModel.checkQuantity(quantity: quantity){
            enterQuantityTextfield.textColor = .black
            self.viewModel.addToCart(productId: productId, quantity: quantity)
            self.dismiss(animated: appAnimation)
        }
        else{
            enterQuantityTextfield.textColor = .appRed
            let message = "Enter quantity between 1 and 8"
            self.callAlert(alertTitle: "Alert!", alertMessage: message)
        }
        
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
        self.scrollView.contentInset.bottom = keyboardHeight - 299
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
    
    @objc func keyboardHide(){
        self.scrollView.contentInset.bottom = .zero
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
    
    override func dismissKeyboard(){
        super.dismissKeyboard()
        containerViewTopConstraint.constant += 70
        isViewAlreadyShifted = false
    }

    @objc func dismissPopUp(){
        self.dismiss(animated: appAnimation, completion: nil)
        containerViewTopConstraint.constant += 70
        isViewAlreadyShifted = false
    }

}

extension BuyNowPopUpViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isViewAlreadyShifted {
            containerViewTopConstraint.constant -= 70
            UIView.animate(withDuration: 0.3) {
            self.containerView.layoutIfNeeded()
            self.isViewAlreadyShifted = true
            }
        }
    }
}
