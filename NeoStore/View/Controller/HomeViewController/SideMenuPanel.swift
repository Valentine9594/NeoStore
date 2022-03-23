//
//  SideMenuPanel.swift
//  NeoStore
//
//  Created by neosoft on 11/03/22.
//

import UIKit
import SideMenu

protocol SideMenuControllerDelegate{
    func didSelectMenuItem(menuItem: MenuItems)
}

class SideMenuController: UITableViewController{
    
    var delegate: SideMenuControllerDelegate?
    var menuItems = [MenuItems]()
    var myCartBadgeNumber: Int = 0
    let menuPanelColor: UIColor = .appBlackForMenuBar
    
    init(with menuItems:[MenuItems]) {
        super.init(nibName: nil, bundle: nil)
        self.menuItems = menuItems
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuTableviewController()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }

    private func setupMenuTableviewController(){
        self.navigationController?.setNavigationBarHidden(true, animated: appAnimation)
        let menuCellNib = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
        tableView.register(menuCellNib, forCellReuseIdentifier: "MenuCell")
        
        let menuHeaderNib = UINib(nibName: "SideMenuTableViewHeader", bundle: nil)
        tableView.register(menuHeaderNib, forHeaderFooterViewReuseIdentifier: "MenuHeader")
        
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = menuPanelColor
        view.backgroundColor = menuPanelColor
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! SideMenuTableViewCell
        let menuItem = menuItems[indexPath.row]
        let imageString = menuItemIconForItem(menuItem: menuItem)
        let menuName = menuItem.description
        let badgeNumber = (menuItem == .myCart) ? myCartBadgeNumber : 0
        cell.loadCell(menuImageString: imageString, menuName: menuName, menuBadgeNumber: badgeNumber)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: appAnimation)
        let menuItem = menuItems[indexPath.row]
        self.delegate?.didSelectMenuItem(menuItem: menuItem)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuHeader") as! SideMenuTableViewHeader
        headerView.loadHeader()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 185
    }
}
