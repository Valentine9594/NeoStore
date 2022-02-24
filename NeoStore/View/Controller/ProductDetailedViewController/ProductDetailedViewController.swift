//
//  ProductDetailedViewController.swift
//  NeoStore
//
//  Created by neosoft on 23/02/22.
//

import UIKit

class ProductDetailedViewController: UIViewController {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productType: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupNavigationBar()
        setupProductImagesCollection()
    }

    private func setupUI(){
        let cornerRadius: CGFloat = 7
        buyNowButton.layer.cornerRadius = cornerRadius
        rateButton.layer.cornerRadius = cornerRadius
        bodyContainerView.layer.cornerRadius = cornerRadius
        descriptionView.layer.cornerRadius = cornerRadius
        imageContainerView.layer.cornerRadius = cornerRadius
        scrollContentView.layer.cornerRadius = cornerRadius
        
        self.productName.text = "Product Name?"
        
        
    }
    
    private func setupProductImagesCollection(){
        let productImagesCollectionCell = UINib(nibName: "ProductImagesCollectionViewCell", bundle: nil)
        productImagesCollectionView.register(productImagesCollectionCell, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        self.productImagesCollectionView.delegate = self
        self.productImagesCollectionView.dataSource = self
    }

    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = self.productName.text
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! ProductImagesCollectionViewCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
}
