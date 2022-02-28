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
    var currentPage = 0
    var productList = [ProductData]()
    
    func totalNumberOfRows() -> Int {
        return productList.count
    }
    
    func getItemAtIndex(index: Int) -> ProductData {
        return productList[index]
    }
    
    func fetchProductData(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int) {
        guard currentPage + 1 == productsPageNumber else{ return }
        
        DispatchQueue.global(qos: .userInteractive).async {
            ProductService.getProductListing(productCategoryId: productCategoryId, productsLimit: productsLimit, productsPageNumber: productsPageNumber){ [weak self] (response) in
                switch response{
                    case .success(let data):
                        if data.status == 200{
                            self?.productList += data.data
                            self?.currentPage += 1
                            self?.tableShouldReload.value = true
                        }
                        
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                        self?.tableShouldReload.value = false
                }
            }
        }

    }
    
}
