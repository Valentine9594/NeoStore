//
//  MyCartTableViewController.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import UIKit

class MyCartTableViewController: UITableViewController, ClickedTableviewCellButton, ClickedDropDownButton {
    var quantity: Int = 1
    var recentTableCellChanged: IndexPath = IndexPath(row: 0, section: 0)
    enum MyCartTableViewCells: String{
        case cartCellReuseIdentifier = "MyCartTableViewCell"
        case lastCellReuseIdentifier = "TotalCell"
        case myCartTableViewFooter = "TableViewFooter"
        
        var description: String{
            rawValue
        }
    }
    var viewModel: MyCartViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyCartTableView()
        setupNavigationBar()
        setupMyCartTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            guard self != nil else{ return }
            switch response{
                case .success:
                    self?.callAlert(alertTitle: "Success", alertMessage: "Order Placed.")
                case .failure:
                    self?.callAlert(alertTitle: "Failure1", alertMessage: "There was an error placing order, Please try again later.")
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
    
    private func setupQuantityOfProduct(productId: Int, quantity: Int){
        self.viewModel.editProductInCart(productId: productId, quantity: quantity)
    }
    
    private func setupMyCartTableView(){
        let myCartTableViewCellNib = UINib(nibName: MyCartTableViewCells.cartCellReuseIdentifier.description, bundle: nil)
        self.tableView.register(myCartTableViewCellNib, forCellReuseIdentifier: MyCartTableViewCells.cartCellReuseIdentifier.description)
        
        let myCartTableViewLastCellNib = UINib(nibName: "TotalCostTableViewCell", bundle: nil)
        self.tableView.register(myCartTableViewLastCellNib, forCellReuseIdentifier: MyCartTableViewCells.lastCellReuseIdentifier.description)
        
        let myCartTableViewFooter = UINib(nibName: "TableViewFooterWithButton", bundle: nil)
        self.tableView.register(myCartTableViewFooter, forHeaderFooterViewReuseIdentifier: MyCartTableViewCells.myCartTableViewFooter.description)
        
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
        
        navigationItem.title = "My Cart"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
        
    }
    
    @objc func popToPreviousViewController(){
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    func didTapDropdown(productId: Int, indexPath: IndexPath){
        let alert = UIAlertController(title: "Quantity", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
//        alert.isModalInPresentation = true
        alert.isModalInPresentation = true
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.addSubview(pickerFrame)
        pickerFrame.delegate = self
        pickerFrame.dataSource = self
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { action in
            self.setupQuantityOfProduct(productId: productId, quantity: self.quantity)
            self.recentTableCellChanged = indexPath
        }
        alert.addAction(doneAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: appAnimation, completion: nil)
    }
    
    func didTapOrderBtn() {
        let selectAddressViewModel = SelectAddressViewModel()
        let selectAddressTableViewController = SelectAddressTableViewController(viewModel: selectAddressViewModel)
        self.navigationController?.pushViewController(selectAddressTableViewController, animated: appAnimation)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.getNumberOfProductsInCart() + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.viewModel.getNumberOfProductsInCart(){
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCartTableViewCells.lastCellReuseIdentifier.description, for: indexPath) as! TotalCostTableViewCell
            cell.addTotalCostOfCart(totalCartCost: self.viewModel.getTotalAmount())
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCartTableViewCells.cartCellReuseIdentifier.description, for: indexPath) as! MyCartTableViewCell
            let currentProductInCart = self.viewModel.getProductInCartAtIndex(index: indexPath.row)
            cell.setupOrderCell(productFromCart: currentProductInCart)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.viewModel.getNumberOfProductsInCart(){
            return 66
        }
        else{
            return 100
        }
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == self.viewModel.getNumberOfProductsInCart(){
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyCartTableViewCells.myCartTableViewFooter.description) as! TableViewFooterWithButton
        footerView.delegate = self
        footerView.loadFooterView(title: "Order Now")
        return footerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let indexNo = indexPath.row
            guard let productId = self.viewModel.getProductInCartAtIndex(index: indexNo)?.productId else{ return }
            self.viewModel.deleteProductFromCart(productId: productId, index: indexNo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) {action, view, success in
            success(true)
        }
        deleteAction.image = UIImage(named: AppIcons.deleteAction.description)
        deleteAction.backgroundColor = .white
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: appAnimation)
    }
}

extension MyCartTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.quantity = row + 1
    }
}
