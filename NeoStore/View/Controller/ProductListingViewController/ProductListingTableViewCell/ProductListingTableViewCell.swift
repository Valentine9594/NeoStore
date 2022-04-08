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
    var productRatings: Int!
    
    func load(productData: ProductData){
        let rating = productData.rating
        let price = productData.cost
        if let name = productData.name, let productDesc = productData.producer{
            var url: URL? = URL(string: "")
            if let imageUrl = productData.productImages?.description{
                url = URL(string: imageUrl)
            }
            DispatchQueue.main.async {
                self.productImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
                self.productNameLabel.text = name.capitalized
                self.productDescriptionLabel.text = productDesc
                self.productPriceLabel.text = "Rs. \(price)"
                self.productRatings = rating
                self.setupProductRating()
            }
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
