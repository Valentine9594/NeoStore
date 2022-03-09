//
//  SelectAddressTableTableViewController.swift
//  NeoStore
//
//  Created by neosoft on 09/03/22.
//

import UIKit

class SelectAddressTableViewController: UITableViewController {
    let cellReuseIdentifier = "SelectAddress"
    var viewModel: SelectAddressViewModelType!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAddresses()
        setupObservers()
    }
    
    init(viewModel: SelectAddressViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.SelectAddressTableViewController.description, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchAddresses(){
        self.viewModel.fetchAllAddresses()
    }
    
    private func setupObservers(){
        self.viewModel.tableShouldReload.bindAndFire { shouldReload in
            if shouldReload{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let selectAddressNib = UINib(nibName: "SelectAddressTableViewCell", bundle: nil)
        self.tableView.register(selectAddressNib, forCellReuseIdentifier: cellReuseIdentifier)
        
//        self.tableView.estimatedRowHeight = 100
//        self.tableView.rowHeight = UITableView.automaticDimension
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
        
        navigationItem.title = "Address List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(clickedAddAddress))
    }
    
    @objc func popToPreviousViewController(){
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    @objc func clickedAddAddress(){
        let addressViewModel = AddressViewModel()
        let addressViewController = AddAddressViewController(viewModel: addressViewModel)
        self.navigationController?.pushViewController(addressViewController, animated: appAnimation)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.getNumberOfAddresses()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SelectAddressTableViewCell
        let username = self.viewModel.fetchUsername()
        let address = self.viewModel.getAddressAtIndex(index: indexPath.row)
        cell.loadCell(userName: username, userAddress: address)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
}
