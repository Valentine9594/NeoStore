//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by neosoft on 03/02/22.
//

import Foundation

enum LoginResult{
    case success
    case failure(error: Error)
    case none
}

protocol LoginViewModelType {
    var loginStatus: ReactiveListener<LoginResult>{get set}
    func getUserLogInDetail(userName: String, userPassword: String)
}

class LoginViewModel: LoginViewModelType{
    
    var loginStatus: ReactiveListener<LoginResult> = ReactiveListener(.none)
    
    func getUserLogInDetail(userName: String, userPassword: String) {
        
        UserService.userLogIn(username: userName, password: userPassword) { [weak self] response in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        debugPrint("Logged In")
                        
                    //                        save data in userdefaults
                        guard let contentData = data.data else{ return }
                        do {
                            try saveLoginAndRegisterDataToUserDefaults(responseContent: contentData)
                            self?.loginStatus.value = .success
                        }
                        catch (let error){
                            debugPrint(error.localizedDescription)
                        }
                    }
                    else{
                        self?.loginStatus.value = .failure(error: CustomErrors.ResponseDataNil)
                    }
                case .failure(let error):
                    self?.loginStatus.value = .failure(error: error)
            }
            
        }
    }
    
}


