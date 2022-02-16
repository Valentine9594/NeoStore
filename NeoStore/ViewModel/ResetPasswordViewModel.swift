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
    func getResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String, accessToken: String)
    func validateResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String) -> Bool
}

class ResetPasswordViewModel: ResetPasswordViewModelType{
    
    var resetPasswordStatus: ReactiveListener<ResetPasswordResult> = ReactiveListener(.none)
    
    func getResetPasswordDetails(currentPassword: String, newPassword: String, confirmPassword: String, accessToken: String) {
        UserService.userResetPassword(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword, accessToken: accessToken) { (response) in
            switch response{
                case .success(let data):
                    guard let content = data as? AnyDict else{
                        self.resetPasswordStatus.value = .none
                        return}
                    
                    if let statusCode = content["status"], statusCode as! Int == 200{
                        self.resetPasswordStatus.value = .success
                    }
                    else{
                        self.resetPasswordStatus.value = .failure
                        debugPrint("cannot convert data: \(String(describing: content["status"]))")
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.resetPasswordStatus.value = .failure
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
