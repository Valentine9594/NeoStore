//
//  ProductListingTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 18/02/22.
//

import UIKit

class ProductListingTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productRatingView: UIView!
    @IBOutlet weak var productRatingStackView: UIStackView!
    @IBOutlet weak var productRatingStar1: UIImageView!
    @IBOutlet weak var productRatingStar2: UIImageView!
    @IBOutlet weak var productRatingStar3: UIImageView!
    @IBOutlet weak var productRatingStar4: UIImageView!
    @IBOutlet weak var productRatingStar5: UIImageView!
    
    var productName: String!
    var productDescription: String!
    var productPrice: Int!
    var productRatings: Int!
    
    func load(productName: String, productDescription: String, productPrice: Int, productRating: Int){
        self.productName = productName
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productRatings = productRating
        
        self.setupProductData()
        self.setupProductRating()
    }
    
    private func setupProductData(){
        DispatchQueue.main.async {
            self.productNameLabel.text = self.productName.capitalized
            self.productDescriptionLabel.text = self.productDescription
            self.productPriceLabel.text = "Rs. \(self.productPrice ?? 0)"
        }
    }
    
    private func setupProductRating(){
        guard let starChecked = UIImage(named: AppIcons.starChecked.description) else{ return }
        guard let starUnchecked = UIImage(named: AppIcons.starUnchecked.description) else{ return }
        let productRatingImageViewArray: [UIImageView] = [productRatingStar1, productRatingStar2, productRatingStar3, productRatingStar4, productRatingStar5]
        
        DispatchQueue.main.async {
            var i: Int = 0
            while i < productRatingImageViewArray.count{
                let currentImageView = productRatingImageViewArray[i]
                var image: UIImage? = nil
                if i <= self.productRatings{
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productRatings = 0
    }
    
}
