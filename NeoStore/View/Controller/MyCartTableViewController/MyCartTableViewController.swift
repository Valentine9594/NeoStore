//
//  MyCartTableViewController.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import UIKit

class MyCartTableViewController: UITableViewController {
    private let cellReuseIdentifier = "MyCartTableViewCell"
    var viewModel: MyCartViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyCartTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        setupMyCartTableViewData()
        setupObservers()
    }
    
    init(viewModel: MyCartViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.MyCartTableViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers(){
        self.viewModel.myCartResult.bindAndFire { [weak self] response in
            guard let `self` = self else{ return }
            switch response{
                case .success:
                    debugPrint("Success")
                case .failure:
                    debugPrint("Failure")
                case .none:
                    break
            }
        }
        
        self.viewModel.tableShouldReload.bindAndFire { [weak self] tableShouldReload in
            if tableShouldReload{
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupMyCartTableViewData(){
        self.viewModel.fetchUserCart()
    }
    
    private func setupMyCartTableView(){
        let myCartTableViewCellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        self.tableView.register(myCartTableViewCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        
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
        
        navigationItem.title = "My Cart"
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
        return self.viewModel.getNumberOfProductsInCart()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MyCartTableViewCell
        let currentProductInCart = self.viewModel.getProductInCartAtIndex(index: indexPath.row)
        cell.setupOrderCell(productFromCart: currentProductInCart)
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 66)) as MyCa
//
//    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
