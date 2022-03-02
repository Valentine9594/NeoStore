//
//  ProductRatingViewModel.swift
//  NeoStore
//
//  Created by neosoft on 01/03/22.
//

import Foundation

enum ProductRatingResultType{
    case success
    case failure
    case none
}

protocol ProductRatingViewModelType {
    var productRatingResult: ReactiveListener<ProductRatingResultType>{get set}
    func setProductRating(productId: String, rating: Int)
}

class ProductRatingViewModel: ProductRatingViewModelType{
    var productRatingResult: ReactiveListener<ProductRatingResultType> = ReactiveListener(.none)
    
    func setProductRating(productId: String, rating: Int) {
        ProductService.setProductRating(productId: productId, rating: rating) { [weak self] response in
            switch response{
                case .success(let data):
                    debugPrint("Status: \(data.status ?? 0)")
                    if data.status == 200{
                        self?.productRatingResult.value = .success
                    }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self?.productRatingResult.value = .failure
            }
        }
    }
    
    
}
