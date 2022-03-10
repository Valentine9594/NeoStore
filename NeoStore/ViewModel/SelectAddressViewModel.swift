//
//  SelectAddressViewModel.swift
//  NeoStore
//
//  Created by neosoft on 09/03/22.
//

import Foundation

enum PlaceOrderResponseType{
    case success(message: String)
    case failure(message: String)
    case none
}

protocol SelectAddressViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get}
    var placeOrderStatus: ReactiveListener<PlaceOrderResponseType>{get}
    func getNumberOfAddresses() -> Int
    func getAddressAtIndex(index: Int) -> String
    func fetchAllAddresses()
    func fetchUsername() -> String
    func placeOrderAtAddress(address: String)
}

class SelectAddressViewModel: SelectAddressViewModelType{
    var placeOrderStatus: ReactiveListener<PlaceOrderResponseType> = ReactiveListener(.none)
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
    
    func placeOrderAtAddress(address: String) {
        OrderService.placeOrderAtAddress(address: address) { [weak self] response in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self?.placeOrderStatus.value = .success(message: data.userMessage ?? "Success")
                    }
                    else{
                        self?.placeOrderStatus.value = .failure(message: data.userMessage ?? "Alert!")
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.placeOrderStatus.value = .failure(message: "Could not place order, please try again.")
            }
        }
    }
}
