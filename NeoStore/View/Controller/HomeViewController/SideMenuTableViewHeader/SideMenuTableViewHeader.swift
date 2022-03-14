//
//  SideMenuTableViewHeader.swift
//  NeoStore
//
//  Created by neosoft on 11/03/22.
//

import UIKit
import SDWebImage

class SideMenuTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var menuEmailLabel: UILabel!
    @IBOutlet weak var menuUsernameLabel: UILabel!
    @IBOutlet weak var menuProfileImageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func loadHeader(){
        DispatchQueue.main.async {
            let userName = getDataFromUserDefaults(key: .username) ?? ""
            let userEmail = getDataFromUserDefaults(key: .email) ?? ""
            let userProfileImageString = getDataFromUserDefaults(key: .profilePicture)
            
            self.menuUsernameLabel.textAlignment = .center
            self.menuEmailLabel.textAlignment = .center
            self.menuUsernameLabel.text = userName
            self.menuEmailLabel.text = userEmail
            
            let radius = self.menuProfileImageView.frame.size.width/2
            self.menuProfileImageView.layer.cornerRadius = radius
            self.menuProfileImageView.layer.borderWidth = 2
            self.menuProfileImageView.layer.borderColor = UIColor.white.cgColor
            self.menuProfileImageView.clipsToBounds = true
            
            if let userProfileImageStringNotNil = userProfileImageString, let imageURL = URL(string: userProfileImageStringNotNil){
                self.menuProfileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: MenuItemIcons.myAccount.description))
            }
        }

    }
    
}
