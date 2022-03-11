//
//  SideMenuTableViewCell.swift
//  NeoStore
//
//  Created by neosoft on 11/03/22.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuBadge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(menuImageString: String, menuName: String, menuBadgeNumber: Int){
        DispatchQueue.main.async {
            if let image = UIImage(named: menuImageString){
                self.menuImageView.image = image
            }
            self.menuLabel.text = menuName.capitalized
            if menuBadgeNumber > 0{
                self.menuBadge.text = "\(menuBadgeNumber)"
                let radius = self.menuBadge.frame.size.width/2
                self.menuBadge.layer.cornerRadius = radius
                self.menuBadge.isHidden = false
            }
            else{
                self.menuBadge.isHidden = true
            }
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
