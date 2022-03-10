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
