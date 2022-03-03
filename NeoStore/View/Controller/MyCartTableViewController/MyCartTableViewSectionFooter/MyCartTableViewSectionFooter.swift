//
//  ViewController.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import UIKit

class MyCartTableViewSectionFooter: UIViewController {
    @IBOutlet weak var totalOrderPrice: UILabel!
    var totalCost: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableViewSectionFooter()
    }


    private func setupTableViewSectionFooter(){
        totalOrderPrice.text = "Rs. \(totalCost ?? 0)"
    }

}
