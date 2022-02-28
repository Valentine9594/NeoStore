//
//  ForgotPasswordViewModel.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import Foundation

enum ForgotPasswordResult{
    case success
    case failure
    case none
}

protocol ForgotPasswordViewModelType {
    var forgotPasswordStatus: ReactiveListener<ForgotPasswordResult>{get set}
    func getUserForgotPasswordDetail(userName: String)
}

class ForgotPasswordViewModel: ForgotPasswordViewModelType{
    var forgotPasswordStatus: ReactiveListener<ForgotPasswordResult> = ReactiveListener(.none)
    
    func getUserForgotPasswordDetail(userName: String) {
        UserService.userForgotPassword(userName: userName) { [weak self] response in
            switch response{
                case .success(let data):
                    
                    guard let content = data as? AnyDict else{
                        self?.forgotPasswordStatus.value = .none
                        return}
                    
                    if let statusCode = content["status"], statusCode as! Int == 200{
                        self?.forgotPasswordStatus.value = .success
                    }
                    else{
                        self?.forgotPasswordStatus.value = .failure
                        debugPrint("cannot convert data!!")
                    }
                    
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    
}

