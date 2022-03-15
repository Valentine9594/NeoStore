//
//  UserDefaults.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import Foundation

enum UserDefaultsKeys: String, CaseIterable{
    case message = "message"
    case userMessage = "user_msg"
    
    case userData = "user_data"
    case productCategories = "product_categories"
    case totalCarts = "total_carts"
    case totalOrders = "total_orders"
    
    case id = "id"
    case roleId = "role_id"
    case firstname = "first_name"
    case lastname = "last_name"
    case email = "email"
    case username = "username"
    case gender = "gender"
    case phoneNo = "phone_no"
    case isActive = "is_active"
    case created = "created"
    case modified = "modified"
    case accessToken = "access_token"
    case dob = "dob"
    case profilePicture = "profile_pic"
    case isProfileUpdated
    case isLoggedIn = "LogIn"
    case address = "address"
    
    var description: String{
        rawValue
    }
}

enum UserDefaultErrors: String, LocalizedError{
    case CannotConvetIntoInteger = "Cannot convert type of Any into Integer."
    case CannotConvetIntoString = "Cannot convert type of Any into String."
    case CannotConvetIntoDate = "Cannot convert type of Any into Date."
    case CannotConvetIntoBool = "Cannot convert type of Any into Boolean."
    
    var errorDescription: String?{
        rawValue
    }
}

extension UserDefaults{
    func setAccessToken(value: Any) throws{
        if let safeValue = value as? String{
            setValue(safeValue, forKey: UserDefaultsKeys.accessToken.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoString
        }

    }
    
    func setId(value: Any) throws{
        if let safeValue = value as? Int{
            setValue(safeValue, forKey: UserDefaultsKeys.id.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoInteger
        }

    }
    
    func setRoleId(value: Any) throws{
        if let safeValue = value as? Int{
            setValue(safeValue, forKey: UserDefaultsKeys.roleId.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoInteger
        }
    }
    
    func setFirstname(value: Any) throws{
        if let safeValue = value as? String{
            setValue(safeValue, forKey: UserDefaultsKeys.firstname.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoString
        }

    }
    
    func setLastname(value: Any) throws{
        if let safeValue = value as? String{
            setValue(safeValue, forKey: UserDefaultsKeys.lastname.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoString
        }

    }
    
    func setEmail(value: Any) throws{
        if let safeValue = value as? String{
            setValue(safeValue, forKey: UserDefaultsKeys.email.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoString
        }

    }
    
    func setUsername(value: Any) throws{
        if let safeValue = value as? String{
            setValue(safeValue, forKey: UserDefaultsKeys.username.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoString
        }

    }
    
    func setGender(value: Any) throws{
        if let safeValue = value as? String{
            setValue(safeValue, forKey: UserDefaultsKeys.gender.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoString
        }
 
    }
    
    func setPhoneNumber(value: Any) throws{
        if let stringValue = value as? String, let safeValue = Int(stringValue){
            setValue(safeValue, forKey: UserDefaultsKeys.phoneNo.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoInteger
        }
    }
    
    func setIsActive(value: Any) throws{
        if let safeValue = value as? Bool{
            setValue(safeValue, forKey: UserDefaultsKeys.isActive.description)
        }
        else{
            throw UserDefaultErrors.CannotConvetIntoBool
        }

    }
    
    func setCreated(value: Any){
        setValue(value, forKey: UserDefaultsKeys.created.description)

    }
    
    func setModified(value: Any){
        setValue(value, forKey: UserDefaultsKeys.modified.description)
    }
    
    func setProfilePicture(value: String?){
        setValue(value, forKey: UserDefaultsKeys.profilePicture.description)
    }
    
    func setDateOfBirth(value: String?){
        setValue(value, forKey: UserDefaultsKeys.dob.description)
    }
    
    func setIsProfileUpdated(value: Bool){
        setValue(value, forKey: UserDefaultsKeys.isProfileUpdated.description)
    }
    
    func setIsLoggedIn(value: Bool){
        setValue(value, forKey: UserDefaultsKeys.isLoggedIn.description)
    }
    
    func setAddress(value: String){
        var addressArray = fetchAddressFromUserDefaults()
        addressArray.append(value)
        let userDefaults = UserDefaults.standard
        userDefaults.set(addressArray, forKey: UserDefaultsKeys.address.description)
//        setValue(value, forKey: UserDefaultsKeys.address.description)
    }
    
//    static func getDataFromUserDefaults<T>(key: UserDefaultsKeys) -> T?{
//
//        if let keyValue = value(forKey: key.description){
//            return keyValue as! T?
//        }
//
//       return nil
//    }
    
}


func saveLoginAndRegisterDataToUserDefaults(responseContent: userResponse) throws{

//    guard let id = responseContent[UserDefaultsKeys.id.description], let roleId = responseContent[UserDefaultsKeys.roleId.description], let firstname = responseContent[UserDefaultsKeys.firstname.description], let lastname = responseContent[UserDefaultsKeys.lastname.description], let email = responseContent[UserDefaultsKeys.email.description], let username = responseContent[UserDefaultsKeys.username.description], let gender = responseContent[UserDefaultsKeys.gender.description], let phoneNo = responseContent[UserDefaultsKeys.phoneNo.description], let isActive = responseContent[UserDefaultsKeys.isActive.description], let created = responseContent[UserDefaultsKeys.created.description], let modified = responseContent[UserDefaultsKeys.modified.description], let accessToken = responseContent[UserDefaultsKeys.accessToken.description] else{
//        throw CustomErrors.CouldNotSaveInUserDefaults }
    
    guard let id = responseContent.id, let roleId = responseContent.roleId, let firstname = responseContent.firstname, let lastname = responseContent.lastname, let email = responseContent.email, let username = responseContent.username, let gender = responseContent.gender, let phoneNo = responseContent.phoneNo, let isActive = responseContent.isActive, let accessToken = responseContent.accessToken else{
        throw CustomErrors.CouldNotSaveInUserDefaults }
    
    let userDefaults = UserDefaults.standard
    
//    guard let createdDate = formatDate(dateStringAny: created), let modifiedDate = formatDate(dateStringAny: modified) else{throw CustomErrors.CouldNotSaveInUserDefaults }
    
//    userDefaults.setCreated(value: createdDate)
//    userDefaults.setModified(value: modifiedDate)
    
    if let profileImageString = responseContent.profilePicture{
        userDefaults.setProfilePicture(value: profileImageString)
    }
    
    if let dobString = responseContent.dob{
        userDefaults.setDateOfBirth(value: dobString)
    }
    
    
    do {
        try userDefaults.setId(value: id)
        try userDefaults.setAccessToken(value: accessToken)
        try userDefaults.setRoleId(value: roleId)
        try userDefaults.setFirstname(value: firstname)
        try userDefaults.setLastname(value: lastname)
        try userDefaults.setEmail(value: email)
        try userDefaults.setUsername(value: username)
        try userDefaults.setGender(value: gender)
        try userDefaults.setPhoneNumber(value: phoneNo)
        try userDefaults.setIsActive(value: isActive)

    } catch let error {
        throw error
    }

}

func fetchAndSaveUserData(responseContent: userResponse) throws{
    
    do {
        try saveLoginAndRegisterDataToUserDefaults(responseContent: responseContent)
    } catch let error {
        throw error
    }

}

func getDataFromUserDefaults(key: UserDefaultsKeys) -> String?{
    let userDefaults = UserDefaults.standard
    if let value = userDefaults.value(forKey: key.description){
        return String(describing: value)
    }
   
    return nil
}

func fetchAddressFromUserDefaults() -> [String]{
    let userDefaults = UserDefaults.standard
    let value = userDefaults.stringArray(forKey: UserDefaultsKeys.address.description) ?? [String]()
    return value
}

//func fetchAllData(){
//    for i in UserDefaultsKeys.allCases{
//        debugPrint("\(i.description): \(getDataFromUserDefaults(key: i))")
//    }
//}

private func formatDate(dateStringAny: Any) -> Date?{
    if let dateString = dateStringAny as? String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateValue = dateFormatter.date(from: dateString)
        debugPrint("Date: \(String(describing: dateValue))")
        return dateValue
    }
    return nil
}




