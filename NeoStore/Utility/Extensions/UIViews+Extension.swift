//
//  UIViews+Extension.swift
//  NeoStore
//
//  Created by neosoft on 15/02/22.
//

import UIKit

extension UINavigationController{
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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

//extension UIView{
//
//    @nonobjc func dismissKeyboard(){
////        function to close keyboard if clicked anywhere
//        self.endEditing(true)
//        self.resignFirstResponder()
//    }
//
//}

//extension UIScrollView{
//
//    @nonobjc func keyboardShow(notification: Notification){
////        code to attach keyboard size when keyboard pops up in scrollview
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
//        let keyboardRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keyboardRectangle.height
//        self.contentInset.bottom = keyboardHeight
//        self.scrollIndicatorInsets = self.contentInset
//    }
//
//    @nonobjc func keyboardHide(){
////        code to adjust scrollview to zero after keyboard closing
//        self.contentInset.bottom = .zero
//        self.scrollIndicatorInsets = self.contentInset
//    }
//}
