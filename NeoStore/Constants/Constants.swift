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
    case ForgotPasswordViewController = "ForgotPasswordViewController"
    case HomeViewController = "HomeViewController"
    case MyAccountViewController = "MyAccountViewController"
    case ResetPasswordViewController = "ResetPasswordViewController"
    case TemporaryMenuBar = "TemporaryMenuBarViewController"
}

//all icons name from assets
enum textFieldIcons: String{
    case usernameIcon = "username_icon"
    case emailIcon = "email_icon"
    case passwordIcon = "password_icon"
    case openPasswordIcon = "cpassword_icon"
    case phoneIcon = "cellphone_icon"
    case dobIcon = "dob_icon"
    case userIcon = "user_male"
}

enum AppIcons: String{
    case menu = "menu_icon"
    case search = "search_icon"
    
    var description: String{
        rawValue
    }
}

extension Notification.Name{
    static let didClickMenuButton = Notification.Name("didClickMenuButton")
}

//custom errors in app
enum CustomErrors: String, LocalizedError{
    case EmptyString = "Empty String Found."
    case NoTextFieldValue = "Textfield Value cannot be found."
    case CannotConvertPhoneNumberFromStringToNumber = "Cannot convert String into Number."
    case CannotConvertJSONObject = "Cannot convert JSON Data."
    case ResponseDataNil = "Response data returned as Nil."
    case PasswordsDoNotMatch = "Password does not match Confirm password."
    case CouldNotSaveInUserDefaults = "Could not save data in userdefaults."
    
    var errorDescription: String?{
        return rawValue
    }
    
}

// all app animations and switching animations true or false
var appAnimation = true


enum ButtonTitles: String{
    case canEdit = "Edit Profile"
    case saveChanges = "Save"
    case done = "Done"
    case cancel = "Cancel"
    
    var description: String?{
        rawValue
    }
}

func jsonParser(jsonData: Data) -> APIResponse<Any>{
//    function to decode data using json decoder/serialisation
    do {
//        let decoder = JSONDecoder()
//        let responseData = try decoder.decode(jsonDataResponse.self, from: jsonData)
        let responseData = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        return .success(value: responseData)
    } catch let error {
        debugPrint(error.localizedDescription)
        return .failure(error: error)
    }
}


