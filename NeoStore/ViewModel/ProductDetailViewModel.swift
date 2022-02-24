//
//  ProductDetailViewModel.swift
//  NeoStore
//
//  Created by neosoft on 24/02/22.
//

import Foundation

protocol ProductDetailViewModelType {
    var viewControllerShouldReload: ReactiveListener<Bool>{get set}
    func fetchProductDetails(productId: Int)
    var productDetails: ProductDetails?{get}
    func totalNumberOfProductImages() -> Int
    func getProductImageAtIndex(index: Int) -> URL?
}

class ProductDetailViewModel: ProductDetailViewModelType{
    var viewControllerShouldReload: ReactiveListener<Bool> = ReactiveListener(false)
    var productDetails: ProductDetails? = nil
    var productImagesList = [String]()
    
    func fetchProductDetails(productId: Int) {
        ProductService.getProductDetails(productId: productId) { (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        debugPrint(data.data)
//                        self.productImagesList += productDetails
                        self.productDetails = data.data
                        self.viewControllerShouldReload.value = true
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.viewControllerShouldReload.value = false
            }        }
    }
    
    func totalNumberOfProductImages() -> Int {
        return productImagesList.count
    }
    
    func getProductImageAtIndex(index: Int) -> URL? {
        let url = URL(string: productImagesList[index])
        return url
    }
    

}
