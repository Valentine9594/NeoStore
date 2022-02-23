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
    private var ratings: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadRatings(ratings: Int){
        self.ratings = ratings - 1
        self.setupRatings()
    }
        
    func setupRatings(){
        guard let starChecked = UIImage(named: AppIcons.starChecked.description) else{ return }
        guard let starUnchecked = UIImage(named: AppIcons.starUnchecked.description) else{ return }
        let imageViewArray: [UIImageView] = [self.starRatingImage1, self.starRatingImage2, self.starRatingImage3, self.starRatingImage4, self.starRatingImage5]
        
        DispatchQueue.main.async {
            var i: Int = 0
            while i < imageViewArray.count{
                let currentImageView = imageViewArray[i]
                var image: UIImage? = nil
                if i <= self.ratings{
                    image = starChecked
                }
                else{
                    image = starUnchecked
                }
                self.changeImageOfImagView(imageView: currentImageView, image: image)
                i += 1
            }
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
