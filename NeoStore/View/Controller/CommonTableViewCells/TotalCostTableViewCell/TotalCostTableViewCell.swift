//
//  MyCartTableViewLastCell.swift
//  NeoStore
//
//  Created by neosoft on 04/03/22.
//

import UIKit

class TotalCostTableViewCell: UITableViewCell {
    @IBOutlet weak var totalCostOfCartLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addTotalCostOfCart(totalCartCost: Int?){
        DispatchQueue.main.async {
            self.totalCostOfCartLabel.text = "₹ \(totalCartCost ?? 0)"
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
