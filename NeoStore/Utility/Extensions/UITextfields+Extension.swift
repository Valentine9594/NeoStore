//
//  UIFont+Extension.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

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
    @nonobjc func setLeftView(image: UIImage){
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        
        leftView = containerView
        leftViewMode = .always
    }
    
    @nonobjc func setCustomTextField(){
//        function to set width, color and placeholder of color
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
//        get placeholde string and change the color of the placeholder text to white
        if let placeHolder = placeholder{
            attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }

    }
}
