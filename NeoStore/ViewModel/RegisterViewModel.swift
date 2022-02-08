//
//  RegisterViewModel.swift
//  NeoStore
//
//  Created by neosoft on 07/02/22.
//

import Foundation

protocol RegisterViewModelType {
    func getUserRegisterDetails(userRegisterDetails: userDetails)
}

class RegisterViewModel: RegisterViewModelType{
    func getUserRegisterDetails(userRegisterDetails: userDetails){
        UserService.userRegistration(userDetails: userRegisterDetails){ response in
            switch response{
                case .success(let data):
                    print(data)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    
}
