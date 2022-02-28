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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
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
        
        //        gesture to close keyboard on cliking anywhere
        let dismissPopUpTap = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        self.view.addGestureRecognizer(dismissPopUpTap)
    }

    @objc func dismissPopUp(){
        self.dismiss(animated: appAnimation, completion: nil)
    }

}
