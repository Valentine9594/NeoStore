//
//  RegisterViewModel.swift
//  NeoStore
//
//  Created by neosoft on 07/02/22.
//

import Foundation

enum LoginResult{
    case success
    case failure
    case none
}

protocol RegisterViewModelType {
//    var loginStatus: ReactiveListener<LoginResult>{get set}
    func getUserRegisterDetails(userRegisterDetails: userDetails)
    func validateUserRegistration(userRegisterDetals: userDetails) -> Bool
}

class RegisterViewModel: RegisterViewModelType{
    
//    var loginStatus: ReactiveListener<LoginResult> = ReactiveListener
    
    func getUserRegisterDetails(userRegisterDetails: userDetails){
//        function which interacts with registerview controller regarding api response and successful registration
        UserService.userRegistration(userDetails: userRegisterDetails){ response in
            switch response{
                case .success(let data):
//                    print(data)
                    print(data)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    func validateUserRegistration(userRegisterDetals: userDetails) -> Bool {
//        function which validates all textfields from register view controller
        let firstName = userRegisterDetals.firstname
        let lastName = userRegisterDetals.lastname
        let email = userRegisterDetals.email
        let password = userRegisterDetals.password
        let confirmPassword = userRegisterDetals.confirmPassword
        let phoneNo = userRegisterDetals.phoneNumber
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
                
        if checkPasswords(passwordString: password, confirmPasswordString: confirmPassword), checkPhoneNo(phoneNo: phoneNo), checkEmail(emailString: email), checkNames(nameString: firstName), checkNames(nameString: lastName){
            return true
        }
        
        return false
    }
    
    func checkPasswords(passwordString: String, confirmPasswordString: String) -> Bool{
        if passwordString.count >= 6, passwordString == confirmPasswordString{
            return true
        }
        return false
    }
    
    func checkPhoneNo(phoneNo: Int) -> Bool{
        if String(phoneNo).count == 10{
            return true
        }
        return false
    }
    
    func checkEmail(emailString: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        print(emailPredicate.evaluate(with: emailString))
        return emailPredicate.evaluate(with: emailString)
    }
    
    func checkNames(nameString: String) -> Bool{
        if nameString != "", nameString.count > 0{
            return true
        }
        return false
    }
    
    
}

