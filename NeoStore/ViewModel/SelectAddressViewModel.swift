//
//  SelectAddressViewModel.swift
//  NeoStore
//
//  Created by neosoft on 09/03/22.
//

import Foundation

protocol SelectAddressViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get}
    func getNumberOfAddresses() -> Int
    func getAddressAtIndex(index: Int) -> String
    func fetchAllAddresses()
    func fetchUsername() -> String
}

class SelectAddressViewModel: SelectAddressViewModelType{
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(false)
    var addressArray = [String]()
    var username = ""
    
    func getNumberOfAddresses() -> Int {
        return addressArray.count
    }
    
    func getAddressAtIndex(index: Int) -> String {
        return addressArray[index]
    }
    
    func fetchAllAddresses(){
        self.addressArray = fetchAddressFromUserDefaults()
        self.tableShouldReload.value = true
    }
    
    func fetchUsername() -> String{
        username = getDataFromUserDefaults(key: .username) ?? ""
        return username
    }
}
