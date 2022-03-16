//
//  UIViewcontroller+Extensions.swift
//  NeoStore
//
//  Created by neosoft on 10/03/22.
//

import UIKit

extension UIViewController{
    @nonobjc func callAlert(alertTitle: String, alertMessage: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            var alertAction: UIAlertAction!
            alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

            alert.addAction(alertAction)
            self.present(alert, animated: appAnimation, completion: nil)
        }
    }
    
    @nonobjc func messageLabelInViewWithText(text: String) -> UIView{
        let sampleView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        let messageLabel = UILabel()
        messageLabel.attributedText = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.appGreyFont, .font: UIFont(name: "iCiel Gotham Medium", size: 20.0)!])
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        sampleView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: sampleView.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: sampleView.centerYAnchor).isActive = true
        return sampleView
    }
    
    @nonobjc func setupNavigationBar(title: String, currentViewController: TotalViewControllers, operation:Selector?){
//        function to setup navigation bar
        navigationController?.isNavigationBarHidden = false
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = .appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]
        
        navigationItem.title = title
        
        switch currentViewController {
            case .HomeViewController:
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: AppIcons.menu.description), style: .plain, target: self, action: operation)
            default:
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousViewController))
        }

        switch currentViewController {
            case .HomeViewController, .MyAccountViewController, .ProductListingViewController, .ProductDetailedViewController, .MyCartTableViewController, .AddAddressViewController, .MyOrdersListTableViewController, .OrderDetailTableViewController:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: AppIcons.search.description), style: .plain, target: self, action: nil)
            case .SelectAddressTableViewController:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: operation)
            default:
                break
        }
    }
    
    @objc func popToPreviousViewController(){
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    @objc func dismissKeyboard(){
//        function to close keyboard if clicked anywhere
        self.view.endEditing(true)
        self.view.resignFirstResponder()
    }

    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        spinnerView.tag = 999
        
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
    }
    
    func removeSpinner(spinnerView: UIView) {
        DispatchQueue.main.async {
            let aiView = spinnerView.viewWithTag(999)
            aiView?.removeFromSuperview()
        }
    }
    
//    @objc func keyboardShow(scrollView: UIScrollView, notification: Notification){
////        code to attach keyboard size when keyboard pops up in scrollview
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
//        let keyboardRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keyboardRectangle.height
//        scrollView.contentInset.bottom = keyboardHeight
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
//        scrollView.isScrollEnabled = true
//    }
//    
//    @objc func keyboardHide(scrollView: UIScrollView){
////        code to adjust scrollview to zero after keyboard closing
//        scrollView.contentInset.bottom = .zero
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
//        scrollView.isScrollEnabled = false
//    }
}
