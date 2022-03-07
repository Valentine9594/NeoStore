//
//  MyOrdersListViewModel.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

protocol MyOrdersListViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get}
    func fetchUserOrdersList()
    func getNumberOfOrdersInList() -> Int
    func getOrderInListAtIndex(index: Int) -> OrderListData?
}

class MyOrdersListViewModel: MyOrdersListViewModelType {
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(false)
    private var userOrderList = [OrderListData]()
    
    func fetchUserOrdersList() {
        OrderService.fetchOrderList { [weak self] response in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        guard let fullCart = data.data else{ return }
                        self?.userOrderList += fullCart
                        self?.tableShouldReload.value = true
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.tableShouldReload.value = false
            }
        }
    }
    
    func getNumberOfOrdersInList() -> Int {
        return userOrderList.count
    }
    
    func getOrderInListAtIndex(index: Int) -> OrderListData? {
        return userOrderList[index]
    }
}
