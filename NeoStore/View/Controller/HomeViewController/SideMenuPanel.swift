//
//  SideMenuPanel.swift
//  NeoStore
//
//  Created by neosoft on 11/03/22.
//

import UIKit
import SideMenu

protocol SideMenuControllerDelegate{
    func didSelectMenuItem(menuItem: String)
}

class SideMenuController: UITableViewController{
    
    var delegate: SideMenuControllerDelegate?
    var menuItems = [String]()
    let menuPanelColor: UIColor = .appBlackForMenuBar
    
    init(with menuItems:[String]) {
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = menuPanelColor
        view.backgroundColor = menuPanelColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = menuPanelColor
        cell.contentView.backgroundColor = menuPanelColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: appAnimation)
        let menuItem = menuItems[indexPath.row]
        self.delegate?.didSelectMenuItem(menuItem: menuItem)
    }
    
}
