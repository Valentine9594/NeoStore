//
//  UserDefaults.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import Foundation

protocol ObjectSavable {
    func setObject<object>(object: object, forKey: String) throws where object: Encodable
    func getObject<object>(forkey: String, castTo type: object.Type) throws -> object where object: Decodable
}

extension UserDefaults: ObjectSavable{
    func setObject<object>(object: object, forKey: String) throws where object : Encodable {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<object>(forkey: String, castTo type: object.Type) throws -> object where object : Decodable {
        guard let data = data(forKey: forkey) else { throw ObjectSavableError.noValue }
        
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        }
        catch {
            throw ObjectSavableError.unableToDecode
        }
    }
    
}

enum ObjectSavableError: String, LocalizedError{
    case unableToEncode = "Unable to encode object into data."
    case unableToDecode = "Unable to decode data into object."
    case noValue = "No data object found for the given value."
    case conversionError = "Cannot convert dictionary into object."
    
    var errorDescription: String?{
        rawValue
    }
}

func getDataAndSaveToUserDefaults(object: AnyDict, key: String){
    
    let userDefaults = UserDefaults.standard
    
    do {
        let convertObject = try convertDictionaryToObject(dictionary: object)
        try userDefaults.setObject(object: convertObject, forKey: key)
    } catch {
        debugPrint(error.localizedDescription)
    }

}

func showUserDefaultsData(key: String) -> userResponse?{
    let userDefaults = UserDefaults.standard
    
    do {
        let userObject = try userDefaults.getObject(forkey: key, castTo: userResponse.self)
        return userObject
    } catch {
        debugPrint(error.localizedDescription)
    }
    return nil
}

enum UserDefaultsKeys: String{
    case userDetails = "UserDetails"
}

func convertDictionaryToObject(dictionary: AnyDict) throws -> userResponse?{
// function to convert dictionary of AnyDict into uerResponse object
    if let firstname = dictionary["first_name"] as! String?,
       let lastname = dictionary["last_name"] as! String?,
       let username = dictionary["username"] as! String?,
       let id = dictionary["id"] as! Int?,
       let roleId = dictionary["role_id"] as! Int?,
       let email = dictionary["email"] as! String?,
       let gender = dictionary["gender"] as! String?,
       let phoneNoString = dictionary["phone_no"] as! String?,
       let isActive = dictionary["is_active"] as! Bool?,
       let createdString = dictionary["created"] as! String?,
       let modifiedString = dictionary["modified"] as! String?,
       let accessToken = dictionary["access_token"] as! String?, let phoneNo = Int(phoneNoString){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let created = dateFormatter.date(from: createdString)
        let modified = dateFormatter.date(from: modifiedString)
        
        let userDetails = userResponse(id: id, roleId: roleId, firstname: firstname, lastname: lastname, email: email, username: username, gender: gender, phoneNo: phoneNo, isActive: isActive, created: created, modified: modified, accessToken: accessToken)
        return userDetails
    }
    else{
        throw ObjectSavableError.conversionError
    }
}

func createUserResponseObject(id: Int, roleId: Int, firstname: String, lastname: String, email: String, username: String, gender: String, phoneNo: Int, isActive: Bool, created: Date, modified: Date, accessToken: String){
    
    debugPrint("Converting into user response object.")
    
}
