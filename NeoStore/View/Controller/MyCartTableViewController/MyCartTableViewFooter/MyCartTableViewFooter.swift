//
//  MyCartTableViewFooter.swift
//  NeoStore
//
//  Created by neosoft on 04/03/22.
//

import UIKit

class MyCartTableViewFooter: UITableViewHeaderFooterView {

    @IBOutlet weak var orderNowButton: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadFooterView(){
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    private func setupUI(){
        self.orderNowButton.layer.cornerRadius = 7
    }
    
    @IBAction func clickedOrderNowButton(_ sender: UIButton) {
        debugPrint("Clicked Order Now Button!")
    }
    
}