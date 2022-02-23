//
//  ProductListingViewController.swift
//  NeoStore
//
//  Created by neosoft on 18/02/22.
//

import UIKit
import SDWebImage

class ProductListingViewController: UIViewController{
    @IBOutlet weak var productListingTableview: UITableView!
    var viewModel: ProductListingViewModelType!
    let productListingCell = "ProductListingCell"
    var productCategory: ProductCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupProductListingTableView()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        self.navigationController?.isNavigationBarHidden = false
        self.viewModel.fetchProductData(productCategoryId: productCategory.id)
        self.setupLoadTableViewData()
    }

    init(viewModel: ProductListingViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ProductListingViewController.rawValue, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoadTableViewData(){
        self.viewModel.tableShouldReload.bindAndFire { shouldReload in
            if shouldReload{
                DispatchQueue.main.async {
                    self.productListingTableview.reloadData()
                }
            }
        }
    }
    
    private func setupProductListingTableView(){
        let productListingCellNib = UINib(nibName: "ProductListingTableViewCell", bundle: nil)
        self.productListingTableview.register(productListingCellNib, forCellReuseIdentifier: productListingCell)
        
        productListingTableview.delegate = self
        productListingTableview.dataSource = self
        
        productListingTableview.estimatedRowHeight = 110
        productListingTableview.rowHeight = UITableView.automaticDimension
    }

    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        let title = getCurrentProductName(productCategoryId: self.productCategory.id)
        navigationItem.title = title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    private func getCurrentProductName(productCategoryId: Int) -> String{
        switch productCategoryId {
            case 0:
                return "Tables"
            case 2:
                return "Chairs"
            case 3:
                return "Sofas"
            case 4:
                return "Cupboards"
            default:
                return "Tables"
        }
    }

}

extension ProductListingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: productListingCell, for: indexPath) as! ProductListingTableViewCell
        
        let productData = self.viewModel.getItemAtIndex(index: indexPath.row)
        
        if let rating: Int = productData.rating, let name = productData.name, let productDesc = productData.description, let price = productData.cost{

            DispatchQueue.global(qos: .userInteractive).async {
                cell.load(productName: name, productDescription: productDesc, productPrice: price, productRating: rating)
            }
            DispatchQueue.main.async {
                guard let imageUrl = productData.productImages?.description else{ return }
                let url = URL(string: imageUrl)
                cell.productImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
//                cell.productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
}

