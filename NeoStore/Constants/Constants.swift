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
//    all screens viewcontroller
    case LoginViewController = "LoginScreenVC"
    case RegisterViewController = "RegisterViewController"
    case ForgotPasswordViewController = "ForgotPasswordViewController"
    case HomeViewController = "HomeViewController"
    case MyAccountViewController = "MyAccountViewController"
    case ResetPasswordViewController = "ResetPasswordViewController"
    case ProductListingViewController = "ProductListingViewController"
    case ProductDetailedViewController = "ProductDetailedViewController"
    case MyCartTableViewController = "MyCartTableViewController"
    case MyOrdersListTableViewController = "MyOrdersListTableViewController"
    case OrderDetailTableViewController = "OrderDetailTableViewController"
    case AddAddressViewController = "AddAddressViewController"
    case SelectAddressTableViewController = "SelectAddressTableViewController"
    
//    popup view controllers
    case rateNowPopUpViewcontroller = "RateNowPopUpViewcontroller"
    case buyNowPopUpViewController = "BuyNowPopUpViewController"
    
//    temporary viewcontrollers
    case TemporaryMenuBar = "TemporaryMenuBarViewController"
    
    var description: String{
        rawValue
    }
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
    case deleteAction = "delete"
    
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
    case canEdit = "EDIT PROFILE"
    case saveChanges = "SUBMIT"
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

func jsonProductDecoder<T: Decodable>(jsonData: Data) -> APIResponse<T>{
    do {
        let formatter = DateFormatter()
        if T.self == OrderListResponse.self || T.self == OrderDetailResponse.self{
            formatter.dateFormat = "dd-MM-yyyy"
        }
        else{
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        let responseData = try jsonDecoder.decode(T.self, from: jsonData)
        return .success(value: responseData)
    } catch let error {
        debugPrint(error.localizedDescription)
        return .failure(error: error)
    }
}

func productCategoryFromId(productCategoryId: Int) -> String{
    switch productCategoryId {
        case 1:
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
