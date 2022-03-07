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
        self.setupNavigationBar()
        self.setupOrderListTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        setupOrderListsTableViewData()
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
        
        navigationItem.title = "My Orders"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
