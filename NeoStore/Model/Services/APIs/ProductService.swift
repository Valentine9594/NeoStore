//
//  ProductList.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

class ProductService{
    static func getProductListing(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int, completion: @escaping(APIResponse<jsonProductResponse<[ProductData]>>)->Void){
        
        let params = [ProductListingParameter.productCategoryId.description: productCategoryId, ProductListingParameter.limit.description: productsLimit, ProductListingParameter.page.description: productsPageNumber]
        
        APIManager.sharedInstance.performRequest(serviceType: .getProductList(parameters: params)) { response in
            
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<jsonProductResponse<[ProductData]>> = jsonProductDecoder(jsonData: content)
                            completion(responseData)
                        }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
            
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func getProductDetails(productId: Int, completion: @escaping(APIResponse<jsonProductResponse<ProductDetails>>)->Void){
        
        let params = [ProductListingParameter.productId.description: productId]
        
        APIManager.sharedInstance.performRequest(serviceType: .getProductDetails(parameters: params)) { response in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<jsonProductResponse<ProductDetails>> = jsonProductDecoder(jsonData: content)
                            completion(responseData)
                        }
                    else{
                        print(CustomErrors.ResponseDataNil.localizedDescription)
                    }
            
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
}


