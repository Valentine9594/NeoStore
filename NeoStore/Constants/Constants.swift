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

// all app animations and switching animations true or false
var appAnimation = true
//enum AppAnimations{
//    case animated = true
//
//}
