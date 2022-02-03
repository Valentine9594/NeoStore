//
//  UIFont+Extension.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation
import  UIKit

extension UITextField{
    func setLeftView(image: UIImage){
        let imageView = UIImageView(frame: CGRect(x: 8, y: 1, width: 18, height: 18))
        imageView.image = image
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 18))
        containerView.addSubview(imageView)
        
        leftView = containerView
        leftViewMode = .always
    }
}
