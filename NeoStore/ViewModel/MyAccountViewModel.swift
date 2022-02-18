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
//    case fetchSuccess
//    case fetchFailure
    case none
    
    var description: String{
        rawValue
    }
}

protocol MyAccountUpdateViewModelType {
    var myAccountUpdateStatus: ReactiveListener<MyAccountUpdateResult>{get set}
    func getmyAccountUpdateDetails(userEditAccountDetails: userAccountDetails)
    func validateEditMyAccountDetails(userEditAccountDetails: userAccountDetails) -> Bool
    func fetchUserAccountDetails()
}

class MyAccountUpdateViewModel: MyAccountUpdateViewModelType{
    
    var myAccountUpdateStatus: ReactiveListener<MyAccountUpdateResult> = ReactiveListener(.none)
    
    func getmyAccountUpdateDetails(userEditAccountDetails: userAccountDetails) {
        UserService.userUpdateAccountDetails(userAccountDetails: userEditAccountDetails) { (response) in
            switch response{
                case .success(let data):
                    guard let content = data as? AnyDict else{
                        self.myAccountUpdateStatus.value = .none
                        return}
                    
                    if let statusCode = content["status"], statusCode as! Int == 200{
                        self.myAccountUpdateStatus.value = .success
                    }
                    else{
                        self.myAccountUpdateStatus.value = .failure
                        debugPrint(content["status"] ?? "NO Code")
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.myAccountUpdateStatus.value = .failure
            }
        }
    }
    
    func fetchUserAccountDetails() {
        UserService.fetchUserAccountDetails { (response) in
            switch response{
                case .success(let data):
                    guard let content = data as? AnyDict else{return}
                    
                    if let statusCode = content["status"], statusCode as! Int == 200{
                        guard let response = content["data"] as? AnyDict else{return}
                        guard let userContent = response[UserDefaultsKeys.userData.description] as? AnyDict else{return}
                        do {
                            try fetchAndSaveUserData(responseContent: userContent)
                        } catch let error {
                            debugPrint(error.localizedDescription)
                        }
                    }
                    else{
                        debugPrint(content["status"] ?? "NO Code")
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    func validateEditMyAccountDetails(userEditAccountDetails: userAccountDetails) -> Bool {
        let firstname = userEditAccountDetails.firstname
        let lastname = userEditAccountDetails.lastname
        let email = userEditAccountDetails.email
        let phoneNo = userEditAccountDetails.phoneNo
        let dob = userEditAccountDetails.dob
        
        if checkNames(nameString: firstname), checkNames(nameString: lastname), checkEmail(emailString: email), checkPhoneNo(phoneNo: phoneNo), checkDOB(dobString: dob){
            return true
        }
        
        return false

    }
    
    func checkDOB(dobString: String?) -> Bool{
        guard let dob = dobString, dob != "" else{ return true }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = .current
        let currentDate = Date()
        guard let birthDate = dateFormatter.date(from: dob) else{ return false }
        
        if currentDate.compare(birthDate) == .orderedDescending{
            return true
        }
        
        return false
    }
    
    func checkPhoneNo(phoneNo: String) -> Bool{
        if phoneNo.count == 10, let _ = Int(phoneNo){
            return true
        }
        return false
    }
    
    func checkEmail(emailString: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: emailString)
    }
    
    func checkNames(nameString: String) -> Bool{
        if nameString.count > 0{
            return true
        }
        return false
    }
}
