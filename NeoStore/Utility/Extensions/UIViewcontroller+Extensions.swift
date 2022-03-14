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
        messageLabel.attributedText = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.appGreyFont, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!])
        messageLabel.textAlignment = .center
        sampleView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: sampleView.topAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: sampleView.leadingAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: sampleView.bottomAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: sampleView.trailingAnchor).isActive = true
        return sampleView
    }
}
