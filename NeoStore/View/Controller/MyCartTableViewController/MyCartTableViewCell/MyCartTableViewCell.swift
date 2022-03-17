//
//  MyCartTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import UIKit
import SDWebImage

protocol ClickedDropDownButton {
    func didTapDropdown(productId: Int, indexPath: IndexPath)
}

class MyCartTableViewCell: UITableViewCell{
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderCategory: UILabel!
    @IBOutlet weak var orderCountIntoPrice: UILabel!
    @IBOutlet weak var orderQuantityButton: UIButton!
    var indexPath: IndexPath!
    var pickerView: UIPickerView!
    var productInCart: CartListProductData!
    var productId: Int!
    var delegate: ClickedDropDownButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupPickerView()
    }
    
    private func setupUI(){
        self.orderQuantityButton.layer.cornerRadius = 7
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
            self.orderCountIntoPrice.text = "₹ \(productDetails.subTotal ?? 0)"
            self.orderQuantityButton.setTitle("  \(cartProduct.quantity ?? 1)", for: .normal)
        }
        self.productId = productDetails.id
    }
    
    private func setupPickerView(){
//        create uianimation, give iboutlet constraint and setHidden as false on selcting button
        self.pickerView = UIPickerView()
    }
    
    @IBAction func clickedDropdownPickerView(_ sender: UIButton) {
        self.delegate.didTapDropdown(productId: self.productId, indexPath: self.indexPath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
