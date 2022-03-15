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
                    if data.status == 200{
                        self?.forgotPasswordStatus.value = .success
                    }
                    else{
                        self?.forgotPasswordStatus.value = .failure
                    }
                    
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    
}

