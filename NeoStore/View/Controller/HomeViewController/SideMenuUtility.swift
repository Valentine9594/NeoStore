//
//  SideMenuUtility.swift
//  NeoStore
//
//  Created by neosoft on 11/03/22.
//

import UIKit

enum MenuItems: String, CaseIterable{
    case myCart = "My Cart"
    case tables = "Tables"
    case sofas = "Sofas"
    case chairs = "Chairs"
    case cupboards = "Cupboards"
    case myAccount = "My Account"
//    case storeLocator = "Store Locator"
    case myOrders = "My Orders"
    case logout = "Logout"
    
    var description: String{
        rawValue
    }
}

enum MenuItemIcons: String{
    case myCart = "shoppingcart_icon"
    case tables = "tables_icon"
    case sofas = "sofa_icon"
    case chairs = "chair_icon"
    case cupboards = "cupboard_icon"
    case myAccount = "username_icon"
//    case storeLocator = "Store Locator"
    case myOrders = "myorders_icon"
    case logout = "logout_icon"
    
    var description: String{
        rawValue
    }
}

func currentMenuItemsViewController(menuItem: MenuItems) -> UIViewController{
    switch menuItem {
        case .myCart:
            let myCartViewModel = MyCartViewModel()
            let viewController = MyCartTableViewController(viewModel: myCartViewModel)
            return viewController
        case .tables:
            let produtListingViewModel = ProductListingViewModel()
            let viewController = ProductListingViewController(viewModel: produtListingViewModel)
            viewController.productCategory = .tables
            return viewController
        case .sofas:
            let produtListingViewModel = ProductListingViewModel()
            let viewController = ProductListingViewController(viewModel: produtListingViewModel)
            viewController.productCategory = .sofas
            return viewController
        case .chairs:
            let produtListingViewModel = ProductListingViewModel()
            let viewController = ProductListingViewController(viewModel: produtListingViewModel)
            viewController.productCategory = .chairs
            return viewController
        case .cupboards:
            let produtListingViewModel = ProductListingViewModel()
            let viewController = ProductListingViewController(viewModel: produtListingViewModel)
            viewController.productCategory = .cupboards
            return viewController
        case .myAccount:
            let myAccountViewModel = MyAccountUpdateViewModel()
            let viewController = MyAccountViewController(viewModel: myAccountViewModel)
            return viewController
        case .myOrders:
            let myOrdersViewModel = MyOrdersListViewModel()
            let viewController = MyOrdersListTableViewController(viewModel: myOrdersViewModel)
            return viewController
        case .logout:
            let loginViewModel = LoginViewModel()
            let viewController = LoginScreenVC(viewModel: loginViewModel)
            UserDefaults.standard.setIsLoggedIn(value: false)
            return viewController
    }
}

func menuItemIconForItem(menuItem: MenuItems) -> String{
    switch menuItem {
        case .myCart:
            return MenuItemIcons.myCart.description
        case .tables:
            return MenuItemIcons.tables.description
        case .sofas:
            return MenuItemIcons.sofas.description
        case .chairs:
            return MenuItemIcons.chairs.description
        case .cupboards:
            return MenuItemIcons.cupboards.description
        case .myAccount:
            return MenuItemIcons.myAccount.description
        case .myOrders:
            return MenuItemIcons.myOrders.description
        case .logout:
            return MenuItemIcons.logout.description
    }
}
