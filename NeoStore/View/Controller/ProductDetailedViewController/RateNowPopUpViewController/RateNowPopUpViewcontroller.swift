//
//  rateNowPopUpViewcontrollerViewController.swift
//  NeoStore
//
//  Created by neosoft on 25/02/22.
//

import UIKit

class RateNowPopUpViewcontroller: UIViewController{
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var rateNowButton: UIButton!
    
//    ratings stars (out of 5)
    @IBOutlet weak var starRating1: UIButton!
    @IBOutlet weak var starRating2: UIButton!
    @IBOutlet weak var starRating3: UIButton!
    @IBOutlet weak var starRating4: UIButton!
    @IBOutlet weak var starRating5: UIButton!
    
    var productDetails: ProductDetails!
    var productRatedOnClick: Int!
    var viewModel: ProductRatingViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupProductDetailsInView()
        setupObservers()
    }

    init(viewModel: ProductRatingViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.rateNowPopUpViewcontroller.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers(){
        self.viewModel.productRatingResult.bindAndFire { [weak self] result in
            switch result{
                case .success:
                    DispatchQueue.main.async {
                        self?.dismiss(animated: appAnimation, completion: nil)
                    }
                case .failure:
                    let message = "There was an error rating the product. Please try again later..."
                    self?.callAlert(alertTitle: "Error!", alertMessage: message)
                case .none:
                    break
            }
        }
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
    }
    
    private func setupGestures(){
        let userInteractionGestures = true
        starRating1.isUserInteractionEnabled = userInteractionGestures
        starRating2.isUserInteractionEnabled = userInteractionGestures
        starRating3.isUserInteractionEnabled = userInteractionGestures
        starRating4.isUserInteractionEnabled = userInteractionGestures
        starRating5.isUserInteractionEnabled = userInteractionGestures
        
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
    
    @objc func dismissPopUp(){
        self.dismiss(animated: appAnimation, completion: nil)
    }
    
    @IBAction func clickedStarRatingButton(_ sender: UIButton) {
        resetRatingsGiven()
        var ratings: Int = 0
        
        if sender == self.starRating1{
            ratings = 1
        }
        else if sender == self.starRating2{
            ratings = 2
        }
        else if sender == self.starRating3{
            ratings = 3
        }
        else if sender == self.starRating4{
            ratings = 4
        }
        else if sender == self.starRating5{
            ratings = 5
        }
        
        changeImageOnButton(ratings: ratings - 1)
        self.productRatedOnClick = ratings
    }
    
    @IBAction func clickedRatingButton(_ sender: UIButton) {
        guard self.productRatedOnClick != nil else{
            self.callAlert(alertTitle: "Error!", alertMessage: "Rate product at least with 1 star.")
            return }
        guard let productId = self.productDetails.id else{ return }
        let productIdString = "\(productId)"
        self.viewModel.setProductRating(productId: productIdString, rating: self.productRatedOnClick)
    }
    
    
    private func changeImageOnButton(ratings: Int){
        let ratingButtonArray: [UIButton] = [starRating1, starRating2, starRating3, starRating4, starRating5]
        let starChecked = UIImage(named: AppIcons.starChecked.description)
        for i in 0...ratings{
            DispatchQueue.main.async {
                ratingButtonArray[i].imageView?.image = starChecked
            }
        }
    }
    
    private func resetRatingsGiven(){
        let ratingButtonArray: [UIButton] = [starRating1, starRating2, starRating3, starRating4, starRating5]
        let starUnchecked = UIImage(named: AppIcons.starUnchecked.description)
        for i in 0..<5{
            DispatchQueue.main.async {
                ratingButtonArray[i].imageView?.image = starUnchecked
            }
        }
    }
    
    @objc func changeStarImage(_ hover: UIHoverGestureRecognizer){
        debugPrint("Hovering")
        switch hover.state {
            case .began:
                let starChecked = UIImage(named: AppIcons.starChecked.description)
                DispatchQueue.main.async {
                    self.starRating1.imageView?.image = starChecked
                }
            case .ended:
                let starUnchecked = UIImage(named: AppIcons.starUnchecked.description)
                DispatchQueue.main.async {
                    self.starRating1.imageView?.image = starUnchecked
                }
            default:
                debugPrint("Default Hover")
                break
        }
        
    }

}
