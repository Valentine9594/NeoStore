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
                case .success(let data):
                    
                    guard let content = data as? AnyDict else{
                        self.loginStatus.value = .none
                        return}
                    
                    
                    if let statusCode = content["status"], statusCode as! Int == 200{
//                        save data in userdefaults
                        guard let contentData = content["data"] as? AnyDict else{ debugPrint("NO CONTENT DATA"); return }
                        getDataAndSaveToUserDefaults(object: contentData, key: UserDefaultsKeys.userDetails.rawValue)
                        let userDetailsAll = showUserDefaultsData(key: UserDefaultsKeys.userDetails.rawValue)
                        print(userDetailsAll ?? "No User Details to Display!!")
                        
                        self.loginStatus.value = .success
                    }
                    else{
                        self.loginStatus.value = .failure
                        debugPrint("cannot convert data!!")
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.loginStatus.value = .failure
            }
            
        }
    }
    
}


