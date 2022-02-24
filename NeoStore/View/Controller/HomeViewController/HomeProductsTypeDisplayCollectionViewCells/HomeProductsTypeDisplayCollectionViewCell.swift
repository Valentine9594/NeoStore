//
//  HomeProductsTypeDisplayCollectionViewCell.swift
//  NeoStore
//
//  Created by neosoft on 11/02/22.
//

import UIKit

class HomeProductsTypeDisplayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTypeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appRed
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
