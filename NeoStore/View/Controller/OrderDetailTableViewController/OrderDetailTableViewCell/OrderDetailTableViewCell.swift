//
//  OrderDetailTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import UIKit
import SDWebImage

class OrderDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderCategoryLabel: UILabel!
    @IBOutlet weak var orderQuantityLabel: UILabel!
    @IBOutlet weak var orderCostLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(orderDetailsData: OrderDetailsData?){
        guard let orderDetailsData = orderDetailsData else{ return }
        DispatchQueue.main.async {
            if let urlString = orderDetailsData.productImage, let url = URL(string: urlString){
                self.orderImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
            }
            self.orderNameLabel.text = orderDetailsData.productName ?? "Unknown"
            self.orderCategoryLabel.text = "(\(orderDetailsData.productCategoryName ?? "Unknown"))"
            self.orderQuantityLabel.text = "QTY: \(orderDetailsData.quantity ?? 1)"
            self.orderCostLabel.text = "Rs. \(orderDetailsData.total ?? 0)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
