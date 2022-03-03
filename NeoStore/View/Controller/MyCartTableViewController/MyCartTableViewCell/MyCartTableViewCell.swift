//
//  MyCartTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import UIKit
import SDWebImage

class MyCartTableViewCell: UITableViewCell {
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderCategory: UILabel!
    @IBOutlet weak var orderCountIntoPrice: UILabel!
    @IBOutlet weak var orderQuantityDropdown: UIStackView!
    @IBOutlet weak var orderQuantityLabel: UILabel!
    var productInCart: CartListProductData!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI(){
        self.orderQuantityDropdown.layer.cornerRadius = 7
        
        let quantityDropdownTap = UITapGestureRecognizer(target: self, action: #selector(clickedQuantityDropdown))
        self.orderQuantityDropdown.addGestureRecognizer(quantityDropdownTap)
    }
    
    func setupOrderCell(productFromCart: CartListProductData?){
        guard let cartProduct = productFromCart else{ return }
        guard let productDetails = cartProduct.product else{ return }
        
        DispatchQueue.main.async {
            self.orderName.text = (productDetails.name ?? "name").capitalized
            if let urlString = productDetails.productImage{
                let url = URL(string: urlString)
                self.orderImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
            }
            let productCategory = (productDetails.productCategory ?? "uknown").capitalized
            self.orderCategory.text = "(\(productCategory))"
            self.orderCountIntoPrice.text = "Rs. \(productDetails.subTotal ?? 0)"
            self.orderQuantityLabel.text = "\(cartProduct.quantity ?? 1)"
        }
    }
    
    @objc func clickedQuantityDropdown(){
        debugPrint("Clicked Quantity Dropdown!")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
