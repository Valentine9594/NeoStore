//
//  SelectAddressTableTableViewController.swift
//  NeoStore
//
//  Created by neosoft on 09/03/22.
//

import UIKit

class SelectAddressTableViewController: UITableViewController, ClickedTableviewCellButton, clickedRadioButton{
    func didTapRadioButton(indexPath: IndexPath) {
        guard indexPath != selectedAddressIndex else { return }
        (self.tableView.cellForRow(at: indexPath) as! SelectAddressTableViewCell).selectAddressButton.isSelected = true
        (self.tableView.cellForRow(at: selectedAddressIndex) as! SelectAddressTableViewCell).selectAddressButton.isSelected = false
        selectedAddressIndex = indexPath
    }
    
    func didTapOrderBtn() {
        let selectedAddress = self.viewModel.getAddressAtIndex(index: selectedAddressIndex.row)
        debugPrint("Selected Address: \(selectedAddress)")
    }
    
    enum SelectAddressTableViewCells: String{
        case addressCellReuseIdentifier = "SelectAddress"
        case footerCellReuseIdenitfier = "TableViewFooter"
    }
    var viewModel: SelectAddressViewModelType!
    var selectedAddressIndex: IndexPath = IndexPath(row: 0, section: 0)
        
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
        self.tableView.register(selectAddressNib, forCellReuseIdentifier: SelectAddressTableViewCells.addressCellReuseIdentifier.rawValue)
        
        let footerNib = UINib(nibName: "TableViewFooterWithButton", bundle: nil)
        self.tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: SelectAddressTableViewCells.footerCellReuseIdenitfier.rawValue)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectAddressTableViewCells.addressCellReuseIdentifier.rawValue, for: indexPath) as! SelectAddressTableViewCell
        let username = self.viewModel.fetchUsername()
        let address = self.viewModel.getAddressAtIndex(index: indexPath.row)
        cell.delegate = self
        cell.indexPath = indexPath
        if indexPath.row == 0{
            cell.selectAddressButton.isSelected = true
        }
        cell.loadCell(userName: username, userAddress: address)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectAddressTableViewCells.footerCellReuseIdenitfier.rawValue) as! TableViewFooterWithButton
        footerView.loadFooterView(title: "Place Order")
        footerView.delegate = self
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 46))
        let headerTitleLabel = UILabel()
        let headerTitle = "Shipping Address"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.appGreyFont, NSAttributedString.Key.font: UIFont(name: "HomepageBaukasten-Book", size: 22.0)!]
        let attributedHeader = NSAttributedString(string: headerTitle, attributes: attributes)
        headerTitleLabel.attributedText = attributedHeader
        headerTitleLabel.textAlignment = .left
        headerView.addSubview(headerTitleLabel)
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12).isActive = true
        headerTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 12).isActive = true
        headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectAddressTableViewCell
        cell.selectAddressButton.isSelected = false
    }
    
}
