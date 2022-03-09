//
//  MyOrderDetailsViewModel.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

protocol MyOrderDetailsViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get}
    func fetchUserOrderDetails(orderId: Int)
    func getNumberOfProductsInOrder() -> Int
    func getProductInOrderAtIndex(index: Int) -> OrderDetailsData?
    func getTotalOrderCost() -> Int?
}

class MyOrderDetailsViewModel: MyOrderDetailsViewModelType{
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(false)
    private var productOrderList = [OrderDetailsData]()
    private var totalOrderCost: Int? = nil
    
    func fetchUserOrderDetails(orderId: Int){
        OrderService.fetchOrderDetails(orderId: orderId){ [weak self] response in
            debugPrint("response : ",response)
            switch response{
                case .success(let data):
                    if data.status == 200{
                        guard let fullOrderList = data.data else{ return }
                        debugPrint(fullOrderList)
//                        self?.productOrderList = fullOrderList.
                        self?.tableShouldReload.value = true
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.tableShouldReload.value = false
            }
        }
    }
    
    func getNumberOfProductsInOrder() -> Int {
        return productOrderList.count
    }
    
    func getProductInOrderAtIndex(index: Int) -> OrderDetailsData? {
        return productOrderList[index]
    }
    
    func getTotalOrderCost() -> Int? {
        return totalOrderCost
    }
}
