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
    case ProductListingViewController = "ProductListingViewController"
    case ProductDetailedViewController = "ProductDetailedViewController"
    
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
    case starChecked = "star_check"
    case starUnchecked = "star_uncheck"
    
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

enum ProductCategory: Int{
    case tables = 1
    case chairs = 2
    case sofas = 3
    case cupboards = 4
    
    var id: Int{
        rawValue
    }
}

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

func jsonProductDecoder<T: Decodable>(jsonData: Data) -> APIResponse<jsonProductResponse<T>>{
    do {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        let responseData = try jsonDecoder.decode(jsonProductResponse<T>.self, from: jsonData)
        return .success(value: responseData)
    } catch let error {
        debugPrint(error.localizedDescription)
        return .failure(error: error)
    }
}

func productCategoryFromId(productCategoryId: Int) -> String{
    switch productCategoryId {
        case 0:
            return "Tables"
        case 2:
            return "Chairs"
        case 3:
            return "Sofas"
        case 4:
            return "Cupboards"
        default:
            return "Tables"
    }
}
