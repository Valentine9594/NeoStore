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
                        do {
                            let json = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
                            print(json)
                            completion(.success(value: json))
                        } catch let error {
                            debugPrint(error.localizedDescription)
                            completion(.failure(error: error))
                        }
                    }
                    else{
                        print("Error!!")
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
                        do {
                            let json = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
                            print(json)
                            completion(.success(value: json))
                        } catch let error {
                            debugPrint(error.localizedDescription)
                            completion(.failure(error: error))
                        }
                    }
                    else{
                        print("Error!!")
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
}
