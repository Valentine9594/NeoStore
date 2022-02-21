//
//  ProductRatingView.swift
//  NeoStore
//
//  Created by neosoft on 18/02/22.
//

import UIKit

class ProductRatingView: UIView{
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var starRatingImage1: UIImageView!
    @IBOutlet weak var starRatingImage2: UIImageView!
    @IBOutlet weak var starRatingImage3: UIImageView!
    @IBOutlet weak var starRatingImage4: UIImageView!
    @IBOutlet weak var starRatingImage5: UIImageView!
    var ratings: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadRatings(ratings: Int){
        self.setupRatingsView()
        self.ratings = ratings - 1
        if self.ratings > 0{
            self.setupProductRatings(stars: self.ratings)
        }
    }
        
    private func setupProductRatings(stars: Int){
            var i: Int = 0
            guard let starChecked = UIImage(named: AppIcons.starChecked.description) else{return}
            let changeImageFunctionArray: [UIImageView] = [self.starRatingImage1, self.starRatingImage2, self.starRatingImage3, self.starRatingImage4, self.starRatingImage5]
            while i < stars{
                debugPrint(i)
                self.changeImageOfImagView(imageView: changeImageFunctionArray[i], image: starChecked)
                i += 1
            }
    }
    
    func setupRatingsView(stars: Int = 5){
            var i: Int = 0
            guard let starUnchecked = UIImage(named: AppIcons.starUnchecked.description) else{return}
            let changeImageFunctionArray: [UIImageView] = [self.starRatingImage1, self.starRatingImage2, self.starRatingImage3, self.starRatingImage4, self.starRatingImage5]
            while i < stars{
                self.changeImageOfImagView(imageView: changeImageFunctionArray[i], image: starUnchecked)
                i += 1
            }
    }
    
    func changeImageOfImagView(imageView: UIImageView, image: UIImage?){
        if let confirmedImage = image{
            DispatchQueue.main.async {
                imageView.image = confirmedImage
            }
        }
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
