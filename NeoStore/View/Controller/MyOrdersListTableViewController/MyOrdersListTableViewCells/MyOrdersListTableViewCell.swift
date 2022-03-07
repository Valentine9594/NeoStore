//
//  MyOrdersListTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import UIKit

class MyOrdersListTableViewCell: UITableViewCell {
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderTotalCostLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(orderData: OrderListData?){
        guard let orderData = orderData else{ return }
        DispatchQueue.main.async {
            self.orderIdLabel.text = "Order Id: \(orderData.id ?? 0)"
            self.orderDateLabel.text = "Order Date: \(String(describing: orderData.created!))"
            self.orderTotalCostLabel.text = "Rs. \(orderData.cost ?? 0)"
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
