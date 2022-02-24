//
//  ProductImagesCollectionViewCell.swift
//  NeoStore
//
//  Created by neosoft on 24/02/22.
//

import UIKit

class ProductImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageSeries: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImageSeries.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
