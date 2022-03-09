//
//  AddAddressViewModel.swift
//  NeoStore
//
//  Created by neosoft on 08/03/22.
//

import Foundation

protocol AddressViewModelType{
    func validateAllData(address: String?, city: String?, state: String?, zipcode: String?, country: String?) -> Bool
    func saveAddressInUserDefaults(address: String)
}

class AddressViewModel: AddressViewModelType{
    private var addressArray = [String?]()
    
    func validateAllData(address: String?, city: String?, state: String?, zipcode: String?, country: String?) -> Bool {
        self.addressArray = [address, city, state, zipcode, country]
        if checkForAllValue(addressArray: addressArray), checkOnlyDigits(value: zipcode), !checkOnlyDigits(value: address), !checkOnlyDigits(value: city), !checkOnlyDigits(value: state), !checkOnlyDigits(value: country){
            return true
        }
        return false
    }
    
    func saveAddressInUserDefaults(address: String) {
        UserDefaults.standard.setAddress(value: address)
    }
    
    private func checkIfNil(value: String?) -> Bool{
        if value != nil, value != ""{
            return true
        }
        return false
    }
    
    private func checkOnlyDigits(value: String?) -> Bool{
        if let notNullValue = value, let _ = Int(notNullValue){
            return true
        }
        return false
    }
    
    private func checkForAllValue(addressArray: [String?]) -> Bool{
        for i in addressArray{
            if !checkIfNil(value: i){
                return false
            }
        }
        return true
    }
}
