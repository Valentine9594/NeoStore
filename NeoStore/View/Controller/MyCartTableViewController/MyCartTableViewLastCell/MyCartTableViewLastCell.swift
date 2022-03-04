//
//  MyCartTableViewLastCell.swift
//  NeoStore
//
//  Created by neosoft on 04/03/22.
//

import UIKit

class MyCartTableViewLastCell: UITableViewCell {
    @IBOutlet weak var totalCostOfCartLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addTotalCostOfCart(totalCartCost: Int?){
        DispatchQueue.main.async {
            self.totalCostOfCartLabel.text = "Rs. \(totalCartCost ?? 0)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
