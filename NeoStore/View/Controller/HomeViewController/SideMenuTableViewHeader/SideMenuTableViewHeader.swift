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
        let userName = getDataFromUserDefaults(key: .username) ?? ""
        let userEmail = getDataFromUserDefaults(key: .email) ?? ""
        let userProfileImageString = getDataFromUserDefaults(key: .profilePicture)
        
        menuUsernameLabel.textAlignment = .center
        menuEmailLabel.textAlignment = .center
        menuUsernameLabel.text = userName
        menuEmailLabel.text = userEmail
        
        let radius = menuProfileImageView.frame.size.width/2
        menuProfileImageView.layer.cornerRadius = radius
        menuProfileImageView.clipsToBounds = true
        
        if let userProfileImageStringNotNil = userProfileImageString, let imageURL = URL(string: userProfileImageStringNotNil){
            menuProfileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: MenuItemIcons.myAccount.description))
        }

    }
    
}
