//
//  TemporaryMenuBarViewController.swift
//  NeoStore
//
//  Created by neosoft on 17/02/22.
//

import UIKit

class TemporaryMenuBarViewController: UIViewController {
    @IBOutlet weak var myAccountButton: UIButton!
    @IBOutlet weak var productListingButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupNavigationBar()
    }

    private func setupUI(){
        myAccountButton.layer.cornerRadius = 7
        productListingButton.layer.cornerRadius = 7
        logOutButton.layer.cornerRadius = 7
    }
    
    private func setupNavigationBar(){
//        function to setup navigation bar
        self.navigationController?.isNavigationBarHidden = false
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "Menu Bar"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController() -> Void{
        self.navigationController?.popViewController(animated: appAnimation)
    }

    @IBAction func clickedMyAccountButton(_ sender: UIButton) {
        let myAccountViewModel = MyAccountUpdateViewModel()
        let myAccountViewController = MyAccountViewController(viewModel: myAccountViewModel)
        navigationController?.pushViewController(myAccountViewController, animated: appAnimation)
    }
    
    
    @IBAction func clickedProductListingButton(_ sender: UIButton) {
        let produtListingViewModel = ProductListingViewModel()
        let productListingViewController = ProductListingViewController(viewModel: produtListingViewModel)
        productListingViewController.productCategory = .tables
        self.navigationController?.pushViewController(productListingViewController, animated: appAnimation)
        

    }
    
    @IBAction func clickedLogOutButton(_ sender: UIButton) {
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginScreenVC(viewModel: loginViewModel)
        UserDefaults.standard.setIsLoggedIn(value: false)
        self.navigationController?.pushViewController(loginViewController, animated: appAnimation)
    }
    
}
