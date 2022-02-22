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
    
    var productImageUrl: URL!
    var productName: String!
    var productDescription: String!
    var productPrice: Int!
    var productRatings: Int!
    
    func load(productImageUrl: URL?, productName: String, productDescription: String, productPrice: Int, productRating: Int){
        self.productImageUrl = productImageUrl
        self.productName = productName
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productRatings = productRating
        
        self.setupProductData()
        self.setupProductRatingView(stars: self.productRatings ?? 0)
    }
    
    private func setupProductData(){
        DispatchQueue.main.async {
            self.productNameLabel.text = self.productName
            self.productDescriptionLabel.text = self.productDescription
            self.productPriceLabel.text = "Rs. \(self.productPrice ?? 0)"
            
            self.productImageView.sd_setImage(with: self.productImageUrl, completed: nil)
        }
    }
    
    private func setupProductRatingView(stars: Int){
        DispatchQueue.main.async {
            
            let productRatingView = UINib(nibName: "ProductRatingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ProductRatingView
            
            productRatingView.translatesAutoresizingMaskIntoConstraints = false
            self.productRatingView.addSubview(productRatingView)
            
            productRatingView.topAnchor.constraint(equalTo: self.productRatingView.topAnchor).isActive = true
            productRatingView.leadingAnchor.constraint(equalTo: self.productRatingView.leadingAnchor).isActive = true
            productRatingView.trailingAnchor.constraint(equalTo: self.productRatingView.trailingAnchor).isActive = true
            productRatingView.bottomAnchor.constraint(equalTo: self.productRatingView.bottomAnchor).isActive = true
            
            productRatingView.loadRatings(ratings: self.productRatings)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productRatings = 0
    }
    
}
