//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by neosoft on 03/02/22.
//

import Foundation

enum LoginResult{
    case success
    case failure
    case none
}

protocol LoginViewModelType {
    var loginStatus: ReactiveListener<LoginResult>{get set}
    func getUserLogInDetail(userName: String, userPassword: String)
}

class LoginViewModel: LoginViewModelType{
    
    var loginStatus: ReactiveListener<LoginResult> = ReactiveListener(.none)
    
    func getUserLogInDetail(userName: String, userPassword: String) {
        
        UserService.userLogIn(username: userName, password: userPassword) { response in
            switch response{
                case .success(_):
                    self.loginStatus.value = .success
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.loginStatus.value = .failure
            }
            
        }
    }
    
}


