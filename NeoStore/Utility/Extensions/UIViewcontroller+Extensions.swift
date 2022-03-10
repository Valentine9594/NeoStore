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
}
