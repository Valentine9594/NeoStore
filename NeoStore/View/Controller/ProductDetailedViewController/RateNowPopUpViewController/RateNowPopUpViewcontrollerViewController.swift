//
//  rateNowPopUpViewcontrollerViewController.swift
//  NeoStore
//
//  Created by neosoft on 25/02/22.
//

import UIKit

class RateNowPopUpViewcontrollerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var rateNowButton: UIButton!
    
//    ratings stars (out of 5)
    @IBOutlet weak var starRating1: UIImageView!
    @IBOutlet weak var starRating2: UIImageView!
    @IBOutlet weak var starRating3: UIImageView!
    @IBOutlet weak var starRating4: UIImageView!
    @IBOutlet weak var starRating5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI(){
        self.view.backgroundColor = .appGreyFont.withAlphaComponent(0.25)
        
        containerView.layer.cornerRadius = 7
        containerView.backgroundColor = .white
        
        productNameLabel.textAlignment = .center
        productNameLabel.numberOfLines = 0
        productNameLabel.lineBreakMode = .byWordWrapping
        productNameLabel.sizeToFit()
        
        rateNowButton.layer.cornerRadius = 7
        
        //        gesture to close keyboard on cliking anywhere
        let dismissPopUpTap = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        self.view.addGestureRecognizer(dismissPopUpTap)
    }

    @objc func dismissPopUp(){
        self.dismiss(animated: appAnimation, completion: nil)
    }

}
