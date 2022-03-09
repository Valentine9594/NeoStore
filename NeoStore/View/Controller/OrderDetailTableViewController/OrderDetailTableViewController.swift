//
//  OrderDetailTableViewController.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import UIKit

class OrderDetailTableViewController: UITableViewController {
    enum OrderDetailTableViewCells: String{
        case orderDetailCellReuseIdentifier = "OrderDetailCell"
        case totalCostLastCell = "TotalCell"
        
        var description: String{
            rawValue
        }
    }
    var viewModel: MyOrderDetailsViewModelType!
    var orderId: Int!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOrderDetailTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        setupOrderDetailTableViewData()
        setupObservers()
    }
    
    init(viewModel: MyOrderDetailsViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.OrderDetailTableViewController.description, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupOrderDetailTableViewData(){
        self.viewModel.fetchUserOrderDetails(orderId: orderId)
    }
    
    private func setupObservers(){
        self.viewModel.tableShouldReload.bindAndFire { [weak self] tableShouldReload in
            if tableShouldReload{
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupOrderDetailTableView(){
        let orderListViewCellNib = UINib(nibName: "OrderDetailTableViewCell", bundle: nil)
        self.tableView.register(orderListViewCellNib, forCellReuseIdentifier: OrderDetailTableViewCells.orderDetailCellReuseIdentifier.description)
        
        let totalCostCellNib = UINib(nibName: "TotalCostTableViewCell", bundle: nil)
        self.tableView.register(totalCostCellNib, forCellReuseIdentifier: OrderDetailTableViewCells.totalCostLastCell.description)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupNavigationBar(){
//        function to setup navigation bar
        self.navigationController?.isNavigationBarHidden = false
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = .appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "Order ID: \(orderId ?? 0)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
        
    }
    
    @objc func popToPreviousViewController(){
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.getNumberOfProductsInOrder() + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.viewModel.getNumberOfProductsInOrder(){
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCells.totalCostLastCell.description, for: indexPath) as! TotalCostTableViewCell
            cell.addTotalCostOfCart(totalCartCost: self.viewModel.getTotalOrderCost())
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCells.orderDetailCellReuseIdentifier.description, for: indexPath) as! OrderDetailTableViewCell
            let orderDetails = self.viewModel.getProductInOrderAtIndex(index: indexPath.row)
            cell.loadCell(orderDetailsData: orderDetails)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.viewModel.getNumberOfProductsInOrder(){
            return 66
        }
        return 100
    }
    
}
