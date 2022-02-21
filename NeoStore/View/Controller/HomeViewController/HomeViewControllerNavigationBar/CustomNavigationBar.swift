//
//  CustomNavigstionBar.swift
//  NeoStore
//
//  Created by neosoft on 14/02/22.
//

import UIKit

class CustomNavigationBar: UIView{
    @IBOutlet weak var menuBarButton: UIButton!
    @IBOutlet weak var searchBarButton: UIButton!
    @IBOutlet weak var appHomeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIandBar()
    }
    
    private func setupUIandBar(){
        self.backgroundColor = UIColor.appRed
    }
    
    @IBAction func clickedMenuButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: .didClickMenuButton, object: nil)

    }
    
    @IBAction func clickedSearchButton(_ sender: UIButton) {
        debugPrint("Clicked Search Button")
    }
    
    
    
}
