//
//  MyCartViewModel.swift
//  NeoStore
//
//  Created by neosoft on 03/03/22.
//

import Foundation

enum MyCartResultType{
    case success
    case failure
    case none
}

protocol MyCartViewModelType {
    var myCartResult: ReactiveListener<MyCartResultType>{get set}
    var tableShouldReload: ReactiveListener<Bool>{get}
    func fetchUserCart()
    func getNumberOfProductsInCart() -> Int
    func getProductInCartAtIndex(index: Int) -> CartListProductData?
    func getTotalAmount() -> Int
    func deleteProductInCartAtIndex(index: Int)
}


class MyCartViewModel: MyCartViewModelType{
    var myCartResult: ReactiveListener<MyCartResultType> = ReactiveListener(.none)
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(false)
    var allProductsInCart = [CartListProductData]()
    var totalCostOfCart: Int = 0
    
    func fetchUserCart() {
        CartService.fetchCart { [weak self] response in
            switch response{
                case .success(let data):
                    debugPrint("Status: \(data.status ?? 0)")
                    if data.status == 200{
                        guard let fullCart = data.data else{ return }
                        self?.allProductsInCart += fullCart
                        self?.totalCostOfCart = data.total ?? 0
//                        self?.myCartResult.value = .success
                        self?.tableShouldReload.value = true
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
//                    self?.myCartResult.value = .failure
                    self?.tableShouldReload.value = false
            }
        }
    }
    
    func getNumberOfProductsInCart() -> Int {
        return allProductsInCart.count
    }
    
    func getProductInCartAtIndex(index: Int) -> CartListProductData? {
        return allProductsInCart[index]
    }
    
    func getTotalAmount() -> Int {
        return totalCostOfCart
    }
    
    func deleteProductInCartAtIndex(index: Int) {
        self.allProductsInCart.remove(at: index)
    }
}
