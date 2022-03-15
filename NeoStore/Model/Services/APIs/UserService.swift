//
//  UserService.swift
//  NeoStore
//
//  Created by neosoft on 03/02/22.
//

import Foundation

class UserService{
    
    static func userLogIn(username: String, password: String, completion: @escaping(APIResponse<jsonDataResponse<userResponse>>)->Void){
        
        let params = ["email": username, "password": password]
        
        APIManager.sharedInstance.performRequest(serviceType: .userLogin(parameters: params)){
            (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
//                        let responseData = jsonParser(jsonData: content)
                        let responseData: APIResponse<jsonDataResponse<userResponse>> = jsonProductDecoder(jsonData: content)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
            
        }
    }
    
    static func userRegistration(userDetails: userDetails, completion: @escaping(APIResponse<jsonDataResponse<userResponse>>)->Void){
        
        let params = ["first_name": userDetails.firstname, "last_name": userDetails.lastname, "email": userDetails.email, "password": userDetails.password, "confirm_password": userDetails.confirmPassword, "gender": userDetails.gender, "phone_no": userDetails.phoneNumber] as AnyDict
        
        APIManager.sharedInstance.performRequest(serviceType: .userRegister(parameters: params)){
            (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
//                        let responseData = jsonParser(jsonData: content)
                        let responseDecoded: APIResponse<jsonDataResponse<userResponse>> = jsonProductDecoder(jsonData: content)
                        completion(responseDecoded)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
    
    static func userForgotPassword(userName: String, completion: @escaping(APIResponse<ForgotPasswordResponse>)->Void){
        let params = ["email": userName]
        
        APIManager.sharedInstance.performRequest(serviceType: .forgotPassword(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<ForgotPasswordResponse> = jsonProductDecoder(jsonData: content)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
    
    static func userResetPassword(currentPassword: String, newPassword: String, confirmPassword: String, completion: @escaping(APIResponse<ForgotPasswordResponse>)->Void){
        let params = ["old_password": currentPassword, "password": newPassword, "confirm_password": confirmPassword]
        
        APIManager.sharedInstance.performRequest(serviceType: .changePassword(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
//                        let responseData = jsonParser(jsonData: content)
                        let responseData: APIResponse<ForgotPasswordResponse> = jsonProductDecoder(jsonData: content)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
    
    static func userUpdateAccountDetails(userAccountDetails: userAccountDetails, completion: @escaping(APIResponse<jsonDataResponse<userResponse>>)->Void){
        
        var dobString: String = ""
        if let string = userAccountDetails.dob{
            dobString = string
        }
        
        var profilePicture: String = ""
        if let string = userAccountDetails.profileImage{
            profilePicture = string
        }
        
        let params = ["first_name": userAccountDetails.firstname, "last_name": userAccountDetails.lastname, "email": userAccountDetails.email, "dob": dobString, "phone_no": userAccountDetails.phoneNo, "profile_pic": profilePicture] as AnyDict
        
        APIManager.sharedInstance.performRequest(serviceType: .updateAccount(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<jsonDataResponse<userResponse>> = jsonProductDecoder(jsonData: content)
                        debugPrint(responseData)
                        completion(responseData)
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
        }
    }
    
    static func fetchUserAccountDetails(completion: @escaping(APIResponse<jsonDataResponse<AccountDetails>>)->Void){
        
        APIManager.sharedInstance.performRequest(serviceType: .getUserDetails) { (response) in
            
            switch response{
            case .success(let data):
                if let content = data as? Data{
                    let responseData: APIResponse<jsonDataResponse<AccountDetails>> = jsonProductDecoder(jsonData: content)
                    completion(responseData)
                }
                else{
                    print(CustomErrors.ResponseDataNil.localizedDescription)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(error: error))
            }
        }
    }
    
}
