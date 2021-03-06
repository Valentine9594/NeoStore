//
//  ProductDetailedViewController.swift
//  NeoStore
//
//  Created by neosoft on 23/02/22.
//

import UIKit
import SDWebImage

class ProductDetailedViewController: UIViewController{
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var ratingStar1: UIImageView!
    @IBOutlet weak var ratingStar2: UIImageView!
    @IBOutlet weak var ratingStar3: UIImageView!
    @IBOutlet weak var ratingStar4: UIImageView!
    @IBOutlet weak var ratingStar5: UIImageView!
    
    @IBOutlet weak var bodyContainerView:
        UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var outOfStockLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    let cellReuseIdentifier = "ProductImagesCollection"
    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    
    var viewModel: ProductDetailViewModelType!
//    var productRatingViewModel: ProductRatingViewModelType!
    var productId: Int!
    var productDetails: ProductDetails!
    var newProductRating: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupNavigationBar(title: "", currentViewController: .ProductDetailedViewController, operation: nil)
        setupProductImagesCollection()
//        self.productRatingViewModel = ProductRatingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
        fetchProductDetails()
        self.showSpinner(onView: self.view)
    }
    
    init(viewModel: ProductDetailViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ProductDetailedViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func fetchProductDetails(){
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.fetchProductDetails(productId: self.productId)
        }
    }
    
    private func setupObservers(){
        self.viewModel.viewControllerShouldReload.bindAndFire { [weak self] shouldReload in
            guard let `self` = self else{ return }
            if shouldReload, let productDetailsViewModel = self.viewModel.productDetails{
                DispatchQueue.main.async {
                    self.productDetails = productDetailsViewModel
                    self.reloadViewController(productDetails: self.productDetails)
                    self.removeSpinner(spinnerView: self.view)
                }
            }
        }
    }
    
    private func reloadViewController(productDetails: ProductDetails){
        self.navigationItem.title = self.viewModel.productDetails?.name ?? "Product"
        
        self.productName.text = productDetails.name?.capitalized
        let productCategoryInText = productCategoryFromId(productCategoryId: productDetails.productCategoryId ?? 1)
        self.productCategory.text = "Category - \(productCategoryInText)"
        self.productProducer.text = productDetails.producer
        self.productPrice.text = "Rs. \(String(describing: productDetails.cost ?? 0))"
        self.productDescription.text = productDetails.description
        self.productImagesCollectionView.reloadData()
        self.setupProductRating(productRatings: productDetails.rating ?? 3)
        
        if let imageURL = self.viewModel.getProductImageURLAtIndex(index: 0){
            self.productImage.sd_setImage(with: imageURL, completed: nil)
            let indexPath = IndexPath(item: 0, section: 0)
            self.productImagesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        }
        
    }

    private func setupUI(){
        let cornerRadius: CGFloat = 7
        buyNowButton.layer.cornerRadius = cornerRadius
        rateButton.layer.cornerRadius = cornerRadius
        bodyContainerView.layer.cornerRadius = cornerRadius
        descriptionView.layer.cornerRadius = cornerRadius
        imageContainerView.layer.cornerRadius = cornerRadius
        scrollContentView.layer.cornerRadius = cornerRadius
        
        productDescription.numberOfLines = 0
        productDescription.lineBreakMode = .byWordWrapping
        productDescription.sizeToFit()
        
        outOfStockLabel.isHidden = true
        
        self.definesPresentationContext = true
    }
    
    private func setupProductImagesCollection(){
        let productImagesCollectionCell = UINib(nibName: "ProductImagesCollectionViewCell", bundle: nil)
        productImagesCollectionView.register(productImagesCollectionCell, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        self.productImagesCollectionView.delegate = self
        self.productImagesCollectionView.dataSource = self
        self.productImagesCollectionView.isMultipleTouchEnabled = false
    }
    
    private func setupProductRating(productRatings: Int){
        guard let starChecked = UIImage(named: AppIcons.starChecked.description) else{ return }
        guard let starUnchecked = UIImage(named: AppIcons.starUnchecked.description) else{ return }
        let productRatingImageViewArray: [UIImageView] = [ratingStar1, ratingStar2, ratingStar3, ratingStar4, ratingStar5]
        
        DispatchQueue.main.async {
            var i: Int = 0
            while i < productRatingImageViewArray.count{
                let currentImageView = productRatingImageViewArray[i]
                var image: UIImage? = nil
                if i <= productRatings{
                    image = starChecked
                }
                else{
                    image = starUnchecked
                }
                self.changeImageOfImageView(imageView: currentImageView, image: image)
                i += 1
            }
        }
    }
    
    private func changeImageOfImageView(imageView: UIImageView, image: UIImage?){
        if let confirmedImage = image{
            DispatchQueue.main.async {
                imageView.image = confirmedImage
            }
        }
    }
    
    @IBAction func clickedShareButton(_ sender: UIButton) {
        debugPrint("Tapped to Share!")
    }
    
    @IBAction func clickedBuyNowButton(_ sender: UIButton) {
        DispatchQueue.main.async {
//            let buyNowPopUp = BuyNowPopUpViewController(nibName: TotalViewControllers.buyNowPopUpViewController.rawValue, bundle: nil)
            let buyNowPopUpViewModel = BuyNowViewModel()
            let buyNowPopUp = BuyNowPopUpViewController(viewModel: buyNowPopUpViewModel)
            buyNowPopUp.modalPresentationStyle = .overCurrentContext
            buyNowPopUp.modalTransitionStyle = .crossDissolve
            buyNowPopUp.productDetails = self.productDetails
            self.present(buyNowPopUp, animated: appAnimation, completion: nil)
        }
    }
    
    @IBAction func clickedRateNowButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            let rateNowPopUpViewModel = ProductRatingViewModel()
            let rateNowPopUp = RateNowPopUpViewcontroller(viewModel: rateNowPopUpViewModel)
            rateNowPopUp.modalPresentationStyle = .overCurrentContext
            rateNowPopUp.modalTransitionStyle = .crossDissolve
            rateNowPopUp.productDetails = self.productDetails
            self.present(rateNowPopUp, animated: appAnimation, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ProductDetailedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.totalNumberOfProductImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! ProductImagesCollectionViewCell
        if let imageURL = self.viewModel.getProductImageURLAtIndex(index: indexPath.row){
            cell.productImageSeries.sd_setImage(with: imageURL, completed: nil)
        }
        if indexPath.row == 0{
            cell.productImageSeries.layer.borderWidth = 2
            cell.productImageSeries.layer.borderColor = UIColor.appGrey.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.size.height
        return CGSize(width: cellHeight * 1.3, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductImagesCollectionViewCell
        cell.productImageSeries.layer.borderWidth = 2
        cell.productImageSeries.layer.borderColor = UIColor.appGrey.cgColor
        if let imageURL = self.viewModel.getProductImageURLAtIndex(index: indexPath.row){
            self.productImage.sd_setImage(with: imageURL, completed: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductImagesCollectionViewCell
        cell.productImageSeries.layer.borderWidth = 0
    }
    
}
