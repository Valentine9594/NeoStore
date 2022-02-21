//
//  ProductListingViewModel.swift
//  NeoStore
//
//  Created by neosoft on 21/02/22.
//

import Foundation

enum ProductListingResult: String{
    case success
    case failure
    case none
    
    var description: String{
        rawValue
    }
}

protocol ProductListingViewModelType {
    var productListingStatus: ReactiveListener<ProductListingResult>{get set}
    var tableShouldReload: ReactiveListener<Bool>{get set}
    func fetchProductData(productCategoryId: Int)
    func totalNumberOfRows() -> Int
    
    func getItemAtIndex(index: Int) -> ProductData
}

class ProductListingViewModel: ProductListingViewModelType{
    var productListingStatus: ReactiveListener<ProductListingResult> = ReactiveListener(.none)
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(true)
    
    var productList = [ProductData]()
    
    func totalNumberOfRows() -> Int {
        return productList.count
    }
    
    func getItemAtIndex(index: Int) -> ProductData {
        return productList[index]
    }
    
    func fetchProductData(productCategoryId: Int) {
        ProductService.getProductListing(productCateoryId: productCategoryId){ (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self.productList += data.data
                        self.productListingStatus.value = .success
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.productListingStatus.value = .failure
            }
        }
        debugPrint("Product Listing View Model.")
    }
    
    
}
