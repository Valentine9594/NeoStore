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
    
    private var viewModel: ProductListingViewModelType!
    private let productListingCell = "ProductListingCell"
    var productCategory: ProductCategory!
    private var productsLimit: Int = 10
    private var pageNumber: Int = 1
    private var bottomCells: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNavigationBarWithTitle()
        self.setupProductListingTableView()
        self.setupFetchingProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLoadTableViewData()
        self.showSpinner(onView: self.view)
    }
    
    init(viewModel: ProductListingViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ProductListingViewController.rawValue, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFetchingProductList(){
        self.viewModel.fetchProductData(productCategoryId: productCategory.id, productsLimit: productsLimit, productsPageNumber: 1)
    }
    
    private func setupLoadTableViewData(){
        self.viewModel.tableShouldReload.bindAndFire { [weak self] shouldReload in
            if shouldReload{
                self?.bottomCells = (self?.pageNumber ?? 1) * (self?.productsLimit ?? 1)
                DispatchQueue.main.async {
                    self?.productListingTableview.reloadData()
                    self?.removeSpinner(spinnerView: (self?.view)!)
                }
            }
        }
    }
    
    private func setupProductListingTableView(){
        let productListingCellNib = UINib(nibName: "ProductListingTableViewCell", bundle: nil)
        self.productListingTableview.register(productListingCellNib, forCellReuseIdentifier: productListingCell)
        
        productListingTableview.delegate = self
        productListingTableview.dataSource = self
        productListingTableview.tableFooterView = UIView(frame: .zero)
        
        DispatchQueue.main.async {
            self.productListingTableview.estimatedRowHeight = 110
            self.productListingTableview.rowHeight = UITableView.automaticDimension
        }

    }
    
    private func setupNavigationBarWithTitle(){
        let title = getCurrentProductName(productCategoryId: self.productCategory.id)
        self.setupNavigationBar(title: title, currentViewController: .ProductListingViewController, operation: nil)
    }
    
    private func getCurrentProductName(productCategoryId: Int) -> String{
        return productCategoryFromId(productCategoryId: productCategoryId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            if let imageUrl = productData.productImages?.description{
                let url = URL(string: imageUrl)
                cell.productImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
            }
//                cell.productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= bottomCells - 4, indexPath.row <= bottomCells{
            self.pageNumber += 1
            self.viewModel.fetchProductData(productCategoryId: productCategory.id, productsLimit: productsLimit, productsPageNumber: pageNumber)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productData = self.viewModel.getItemAtIndex(index: indexPath.row)
        let productDetailViewModel = ProductDetailViewModel()
        let productDetailedViewController = ProductDetailedViewController(viewModel: productDetailViewModel)
        productDetailedViewController.productId = productData.id
        self.navigationController?.pushViewController(productDetailedViewController, animated: appAnimation)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 110
//    }
    
}

