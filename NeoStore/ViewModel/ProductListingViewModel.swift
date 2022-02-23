//
//  ProductListingViewModel.swift
//  NeoStore
//
//  Created by neosoft on 21/02/22.
//

import Foundation

protocol ProductListingViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get set}
    func fetchProductData(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int)
    
    func totalNumberOfRows() -> Int
    func getItemAtIndex(index: Int) -> ProductData
}

class ProductListingViewModel: ProductListingViewModelType{
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(true)
    
    var productList = [ProductData]()
    
    func totalNumberOfRows() -> Int {
        return productList.count
    }
    
    func getItemAtIndex(index: Int) -> ProductData {
        return productList[index]
    }
    
    func fetchProductData(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int) {
        ProductService.getProductListing(productCategoryId: productCategoryId, productsLimit: productsLimit, productsPageNumber: productsPageNumber){ (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self.productList += data.data
                        self.tableShouldReload.value = true
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.tableShouldReload.value = false
            }
        }

    }

    
}
