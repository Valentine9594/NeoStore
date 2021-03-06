//
//  ResetPasswordViewModel.swift
//  NeoStore
//
//  Created by neosoft on 15/02/22.
//

import Foundation

enum ResetPasswordResult: String{
    case success
    case failure
    case none
    
    var description: String{
        rawValue
    }
}

protocol ResetPasswordViewModelType {
    var resetPasswordStatus: ReactiveListener<ResetPasswordResult>{get set}
    func getResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String)
    func validateResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String) -> Bool
}

class ResetPasswordViewModel: ResetPasswordViewModelType{
    
    var resetPasswordStatus: ReactiveListener<ResetPasswordResult> = ReactiveListener(.none)
    
    func getResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String) {
        UserService.userResetPassword(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword) { [weak self] (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self?.resetPasswordStatus.value = .success
                    }
                    else{
                        self?.resetPasswordStatus.value = .failure
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.resetPasswordStatus.value = .failure
            }
        }
    }
    
    func validateResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String) -> Bool {
        let firstValidation = checkOldAndNewPassword(oldPassword: currentPassword, newPassword: newPassword)
        let secondValidation = checkConfirmPassword(newPassword: newPassword, confirmPassword: confirmPassword)
        if firstValidation && secondValidation{
            return true
        }
        return false
    }
    
    func checkOldAndNewPassword(oldPassword: String, newPassword: String) -> Bool{
        if oldPassword == newPassword{
            return false
        }
        return true
    }
    
    func checkConfirmPassword(newPassword: String, confirmPassword: String) -> Bool{
        if newPassword.count >= 6, newPassword == confirmPassword{
            return true
        }
        return false
    }
    
}
