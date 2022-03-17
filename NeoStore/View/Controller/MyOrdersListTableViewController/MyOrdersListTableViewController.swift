//
//  MyOrdersListTableViewController.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import UIKit

class MyOrdersListTableViewController: UITableViewController {
    let orderCellReuseIdentifier = "OrderListCell"
    var viewModel: MyOrdersListViewModelType!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "My Orders", currentViewController: .MyOrdersListTableViewController, operation: nil)
        self.setupOrderListTableView()
        self.setupOrderListsTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
    }
    
    init(viewModel: MyOrdersListViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.MyOrdersListTableViewController.description, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupOrderListsTableViewData(){
        self.viewModel.fetchUserOrdersList()
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
    
    private func setupOrderListTableView(){
        let orderListViewCellNib = UINib(nibName: "MyOrdersListTableViewCell", bundle: nil)
        self.tableView.register(orderListViewCellNib, forCellReuseIdentifier: orderCellReuseIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.getNumberOfOrdersInList()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: orderCellReuseIdentifier, for: indexPath) as! MyOrdersListTableViewCell
        let orderListSample = self.viewModel.getOrderInListAtIndex(index: indexPath.row)
        cell.loadCell(orderData: orderListSample)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: appAnimation)
        let orderDetailsViewModel = MyOrderDetailsViewModel()
        let orderDetailsTableViewController = OrderDetailTableViewController(viewModel: orderDetailsViewModel)
        let orderId = self.viewModel.getOrderInListAtIndex(index: indexPath.row)?.id
        orderDetailsTableViewController.orderId = orderId
        self.navigationController?.pushViewController(orderDetailsTableViewController, animated: appAnimation)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.viewModel.getNumberOfOrdersInList() == 0{
            let footerView = self.messageLabelInViewWithText(text: "You have not placed any order yet!")
            return footerView
        }
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
