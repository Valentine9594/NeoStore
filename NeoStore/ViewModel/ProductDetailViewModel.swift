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
    func getProductImageURLAtIndex(index: Int) -> URL?
}

class ProductDetailViewModel: ProductDetailViewModelType{
    
    var viewControllerShouldReload: ReactiveListener<Bool> = ReactiveListener(false)
    var productDetails: ProductDetails? = nil
    var productImagesList = [ProductImagesCollection]()
    
    func fetchProductDetails(productId: Int) {
        ProductService.getProductDetails(productId: productId) { (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self.productDetails = data.data
                        if let productImages = self.productDetails?.productImages{
                            self.productImagesList = productImages
                        }
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
    
    func getProductImageURLAtIndex(index: Int) -> URL? {
        if let productImageURLString = productImagesList[index].productImages{
            let url = URL(string: productImageURLString)
            return url
        }
        return nil
    }
    

}
