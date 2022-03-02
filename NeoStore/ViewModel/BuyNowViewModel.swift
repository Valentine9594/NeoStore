//
//  BuyNowViewModel.swift
//  NeoStore
//
//  Created by neosoft on 02/03/22.
//

import Foundation

enum BuyNowResultType{
    case success
    case failure(message: String)
    case none
}

protocol BuyNowViewModelType {
    var buyNowRatingResult: ReactiveListener<BuyNowResultType>{get set}
    func addToCart(productId: Int, quantity: Int)
    func checkQuantity(quantity: Int) -> Bool
}

class BuyNowViewModel: BuyNowViewModelType{
    var buyNowRatingResult: ReactiveListener<BuyNowResultType> = ReactiveListener(.none)
    
    func addToCart(productId: Int, quantity: Int) {
        CartService.addToCart(productId: productId, quantity: quantity) { [weak self] (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self?.buyNowRatingResult.value = .success
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.buyNowRatingResult.value = .failure(message: "An Error occurred when adding product to Cart.")
            }
        }
    }
    
    func checkQuantity(quantity: Int) -> Bool {
        if quantity > 0, quantity <= 7{
            return true
        }
        return false
    }

}
