//
//  UserService.swift
//  NeoStore
//
//  Created by neosoft on 03/02/22.
//

import Foundation

class UserService{
    
    static func userLogIn(username: String, password: String, completion: @escaping(APIResponse<Any>)->Void){
        
        let params = ["email": username, "password": password]
        
        APIManager.sharedInstance.performRequest(serviceType: .userLogin(parameters: params)){
            (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData = jsonParser(jsonData: content)
                        print(responseData)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.description)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
            
        }
    }
    
    static func userRegistration(userDetails: userDetails, completion: @escaping(APIResponse<Any>)->Void){
        
        let params = ["first_name": userDetails.firstname, "last_name": userDetails.lastname, "email": userDetails.email, "password": userDetails.password, "confirm_password": userDetails.confirmPassword, "gender": userDetails.gender, "phone_no": userDetails.phoneNumber] as AnyDict
        
        APIManager.sharedInstance.performRequest(serviceType: .userRegister(parameters: params)){
            (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData = jsonParser(jsonData: content)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.description)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
    
    static func userForgotPassword(userName: String, completion: @escaping(APIResponse<Any>)->Void){
        let params = ["email": userName]
        
        APIManager.sharedInstance.performRequest(serviceType: .forgotPassword(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData = jsonParser(jsonData: content)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.description)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
    
    
    
}
