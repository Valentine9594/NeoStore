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
    var forgotPasswordStatus: ReactiveListener<LoginResult>{get set}
    func getUserForgotPasswordDetail(userName: String, userPassword: String)
}

class ForgotPasswordViewModel: ForgotPasswordViewModelType{
    var forgotPasswordStatus: ReactiveListener<LoginResult> = ReactiveListener(.none)
    
    func getUserForgotPasswordDetail(userName: String, userPassword: String) {
        print("Forgot Password ViewModel")
    }
    
    
}

