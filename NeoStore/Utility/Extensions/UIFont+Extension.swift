//
//  UIFont+Extension.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation
import  UIKit

func setTextField(textfield: UITextField ,image: UIImage?){
//        function to set border width, color and left image in a textfield
    textfield.setCustomTextField()
    if let img = image{
        textfield.setLeftView(image: img)
    }
}

extension UITextField{
    
//    function to set image to the left of textfields
    func setLeftView(image: UIImage){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 25, height: 30))
        imageView.image = image
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        containerView.addSubview(imageView)
        
        leftView = containerView
        leftViewMode = .always
    }
    
    func setCustomTextField(){
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}
