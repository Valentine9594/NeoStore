//
//  MyAccountViewModel.swift
//  NeoStore
//
//  Created by neosoft on 15/02/22.
//

import Foundation

enum MyAccountUpdateResult: String{
    case success
    case failure
    case none
    
    var description: String{
        rawValue
    }
}

protocol MyAccountUpdateViewModelType {
    var myAccountUpdateStatus: ReactiveListener<MyAccountUpdateResult>{get set}
    func getmyAccountUpdateDetails(userEditAccountDetails: userAccountDetails)
//    func validateResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String) -> Bool
}

class MyAccountUpdateViewModel: MyAccountUpdateViewModelType{
    var myAccountUpdateStatus: ReactiveListener<MyAccountUpdateResult> = ReactiveListener(.none)
    
    func getmyAccountUpdateDetails(userEditAccountDetails: userAccountDetails) {
        debugPrint("in my account view model")
    }
    
    
}
