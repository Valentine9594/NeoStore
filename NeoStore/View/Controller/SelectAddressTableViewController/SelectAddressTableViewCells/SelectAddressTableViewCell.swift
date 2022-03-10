//
//  SelectAddressTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 09/03/22.
//

import UIKit

protocol clickedRadioButton {
    func didTapRadioButton(indexPath: IndexPath)
}

class SelectAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var selectAddressButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    var delegate: clickedRadioButton?
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(userName: String?, userAddress: String?){
        DispatchQueue.main.async {
            self.userAddressLabel.numberOfLines = 0
            self.userAddressLabel.lineBreakMode = .byWordWrapping
            
            self.wrapperView.layer.cornerRadius = 7
            self.wrapperView.layer.borderWidth = 1
            self.wrapperView.layer.borderColor = UIColor.appGrey.cgColor
            
            self.userNameLabel.text = userName ?? ""
            self.userAddressLabel.text = userAddress ?? ""
        }
    }
    
    @IBAction func clickedSelectAddressButton(_ sender: UIButton) {
        if selectAddressButton.isSelected{
            selectAddressButton.isSelected = false
            self.delegate?.didTapRadioButton(indexPath: IndexPath(row: 0, section: 0))
        }
        else if !selectAddressButton.isSelected{
            selectAddressButton.isSelected = true
            self.delegate?.didTapRadioButton(indexPath: indexPath)
        }

    }
    
    
}
