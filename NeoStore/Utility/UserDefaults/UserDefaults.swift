//
//  UserDefaults.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import Foundation

enum UserDefaultsKeys: String{
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
            setValue(safeValue, forKey: UserDefaultsKeys.firstname.description)
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
    
}


func saveDataToUserDefaults(responseContent: AnyDict) throws{
    
    let userDefaults = UserDefaults.standard

    guard let id = responseContent[UserDefaultsKeys.id.description], let roleId = responseContent[UserDefaultsKeys.roleId.description], let firstname = responseContent[UserDefaultsKeys.firstname.description], let lastname = responseContent[UserDefaultsKeys.lastname.description], let email = responseContent[UserDefaultsKeys.email.description], let username = responseContent[UserDefaultsKeys.username.description], let gender = responseContent[UserDefaultsKeys.gender.description], let phoneNo = responseContent[UserDefaultsKeys.phoneNo.description], let isActive = responseContent[UserDefaultsKeys.isActive.description], let created = responseContent[UserDefaultsKeys.created.description], let modified = responseContent[UserDefaultsKeys.modified.description], let accessToken = responseContent[UserDefaultsKeys.accessToken.description] else{
        throw CustomErrors.CouldNotSaveInUserDefaults }
    
//    guard let createdDate = formatDate(dateStringAny: created), let modifiedDate = formatDate(dateStringAny: modified) else{throw CustomErrors.CouldNotSaveInUserDefaults }
    
    debugPrint("NOW SAVING IN USERDEFAULTS")
    
//    userDefaults.setCreated(value: createdDate)
//    userDefaults.setModified(value: modifiedDate)
    userDefaults.setCreated(value: created)
    userDefaults.setModified(value: modified)
    
    
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

func getDataFromUserDefaults(key: UserDefaultsKeys) -> String?{
    let userDefaults = UserDefaults.standard
    
    if let value = userDefaults.value(forKey: key.description){
        return String(describing: value)
    }
   
    return nil
}

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




