//
//  ProductListingViewController.swift
//  NeoStore
//
//  Created by neosoft on 18/02/22.
//

import UIKit

class ProductListingViewController: UIViewController{
    @IBOutlet weak var productListingTableview: UITableView!
    let productListingCell = "ProductListingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupProductListingTableView()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        self.navigationController?.isNavigationBarHidden = false
    }

    private func setupProductListingTableView(){
        let productListingCellNib = UINib(nibName: "ProductListingTableViewCell", bundle: nil)
        self.productListingTableview.register(productListingCellNib, forCellReuseIdentifier: productListingCell)
        
        productListingTableview.delegate = self
        productListingTableview.dataSource = self
    }

    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "Product?"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
    }

}

extension ProductListingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: productListingCell, for: indexPath) as! ProductListingTableViewCell
        
        let rating: Int = Int.random(in: 2..<5)
        debugPrint("Actual Rating: \(rating)")
        var productImage: UIImage? = nil
        if let image = UIImage(named: "slider_img1"){
            productImage = image
        }
        
        cell.load(productImage: productImage, productName: "Sample Name", productDescription: "Sample Description", productPrice: 10, productRating: rating)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
