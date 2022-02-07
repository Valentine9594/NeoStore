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
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    
}
