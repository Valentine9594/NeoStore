//
//  Constants.swift
//  NeoStore
//
//  Created by neosoft on 01/02/22.
//

import Foundation

//API Response which is return type
enum APIResponse<T>{
    case success(value: T)
    case failure(error: Error)
}

//all view controller prsent in app
enum TotalViewControllers: String{
    case LoginViewController = "LoginScreenVC"
    case RegisterViewController = "RegisterViewController"
}

//all icons name from assets
enum textFieldIcons: String{
    case usernameIcon = "username_icon"
    case emailIcon = "email_icon"
    case passwordIcon = "password_icon"
    case openPasswordIcon = "cpassword_icon"
    case phoneIcon = "cellphone_icon"
}

//custom errors in app
enum CustomErrors: Error{
    case EmptyString
    case NoTextFieldValue
    case CannotConvertPhoneNumberFromStringToNumber
    case CannotConvertJSONObject
    case ResponseDataNil
    case PasswordsDoNotMatch
}

extension CustomErrors{
    var description: String{
        switch self{
            case .ResponseDataNil: return "Response data eturned as Nil."
            case .EmptyString: return "Empty String Found."
            case .NoTextFieldValue: return "Textfield Value cannot be found."
            case .CannotConvertPhoneNumberFromStringToNumber: return "Cannot convert String into Number."
            case .CannotConvertJSONObject: return "Cannot convert JSON Data."
            case .PasswordsDoNotMatch: return "Password does not match Confirm password."
        }
    }
}

// all app animations and switching animations true or false
var appAnimation = true
//enum AppAnimations{
//    case animated = true
//
//}
