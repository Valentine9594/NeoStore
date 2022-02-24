//
//  ProductDetailedViewController.swift
//  NeoStore
//
//  Created by neosoft on 23/02/22.
//

import UIKit
import SDWebImage

class ProductDetailedViewController: UIViewController {
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
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    let cellReuseIdentifier = "ProductImagesCollection"
    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    var viewModel: ProductDetailViewModelType!
    var productId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupNavigationBar()
        setupProductImagesCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        setupObservers()
        fetchProductDetails()
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
            if shouldReload, self.viewModel.productDetails != nil{
                DispatchQueue.main.async {
                    self.reloadViewController(productDetails: self.viewModel.productDetails!)
                    self.productImagesCollectionView.reloadData()
                    self.navigationItem.title = self.viewModel.productDetails?.name ?? ""
                }
            }
        }
    }
    
    private func reloadViewController(productDetails: ProductDetails){
        self.productName.text = productDetails.name
        let productCategoryInText = productCategoryFromId(productCategoryId: productDetails.productCategoryId ?? 1)
        self.productCategory.text = "Category - \(productCategoryInText)"
        self.productProducer.text = productDetails.producer
        self.productPrice.text = "Rs. \(String(describing: productDetails.cost ?? 0))"
        self.productDescription.text = productDetails.description
        
        if let imageURL = self.viewModel.getProductImageURLAtIndex(index: 0){
            self.productImage.sd_setImage(with: imageURL, completed: nil)
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
        
    }
    
    private func setupProductImagesCollection(){
        let productImagesCollectionCell = UINib(nibName: "ProductImagesCollectionViewCell", bundle: nil)
        productImagesCollectionView.register(productImagesCollectionCell, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        self.productImagesCollectionView.delegate = self
        self.productImagesCollectionView.dataSource = self
        self.productImagesCollectionView.isMultipleTouchEnabled = false
    }

    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @IBAction func clickedShareButton(_ sender: UIButton) {
        debugPrint("Tapped to Share!")
    }
    
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.size.height
        return CGSize(width: cellHeight * 1.125, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductImagesCollectionViewCell
        cell.containerView.backgroundColor = .lightGray
        if let imageURL = self.viewModel.getProductImageURLAtIndex(index: indexPath.row){
            self.productImage.sd_setImage(with: imageURL, completed: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductImagesCollectionViewCell
        cell.containerView.backgroundColor = .white
    }
}
