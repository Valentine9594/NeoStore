//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by neosoft on 03/02/22.
//

import Foundation

protocol LoginViewModelType {
    func getUserLogInDetail(userName: String, userPassword: String)
}

class LoginViewModel: LoginViewModelType{
    func getUserLogInDetail(userName: String, userPassword: String) {
        UserService.userLogIn(username: userName, password: userPassword) { response in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        do {
                            let json = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
                            print(json)
                        } catch let error {
                            debugPrint(error.localizedDescription)
                        }
                    }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
                print(data)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
            
        }
    }
    

    
}


