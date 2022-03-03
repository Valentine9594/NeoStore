//
//  MyCartTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .appRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
