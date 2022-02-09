//
//  ForgotPasswordViewController.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var viewModel: ForgotPasswordViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
//            self.setupObserver()
//            self.setupNavigationBar()
        }
    }
    
    init(viewModel: ForgotPasswordViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.ForgotPasswordViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        self.view.backgroundColor = UIColor.appRed
        
        setTextField(textfield: usernameTextField, image: UIImage(named: textFieldIcons.usernameIcon.rawValue))
        
        sendButton.layer.cornerRadius = 7
    }

    @IBAction func sendButtonAction(_ sender: UIButton) {
        debugPrint("Clicking Send Button!")
    }
    
    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = self.view.backgroundColor
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = "Forgot Password"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
    }
    
    @objc func popToPreviousViewController(){
        self.navigationController?.popViewController(animated: appAnimation)
    }

    
}
