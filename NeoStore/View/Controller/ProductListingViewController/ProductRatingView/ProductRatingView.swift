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
        self.ratings = ratings
        setupProductRatings(stars: self.ratings ?? 0)
    }
        
    private func setupProductRatings(stars: Int){
        DispatchQueue.main.async {
            var i: Int = 0
            guard let starChecked = UIImage(named: AppIcons.starChecked.description) else{return}
            let changeImageFunctionArray: [()] = [self.changeImage1(image: starChecked), self.changeImage2(image: starChecked), self.changeImage3(image: starChecked), self.changeImage4(image: starChecked), self.changeImage5(image: starChecked)]
            while i < stars{
                changeImageFunctionArray[i]
                i += 1
            }
        }
    }
    
    func createAllUnchecked(){
        DispatchQueue.main.async {
            guard let starUnchecked = UIImage(named: AppIcons.starUnchecked.description) else{return}
            self.changeImage1(image: starUnchecked)
            self.changeImage2(image: starUnchecked)
            self.changeImage3(image: starUnchecked)
            self.changeImage4(image: starUnchecked)
            self.changeImage5(image: starUnchecked)
        }
    }
    
    func changeImage1(image: UIImage){
        self.starRatingImage1.image = image
    }
    
    func changeImage2(image: UIImage){
        self.starRatingImage1.image = image
    }
    
    func changeImage3(image: UIImage){
        self.starRatingImage1.image = image
    }
    
    func changeImage4(image: UIImage){
        self.starRatingImage1.image = image
    }
    
    func changeImage5(image: UIImage){
        self.starRatingImage1.image = image
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
