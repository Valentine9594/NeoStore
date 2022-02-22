//
//  ProductList.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

class ProductService{
    static func getProductListing(productCateoryId: Int, completion: @escaping(APIResponse<jsonProductResponse>)->Void){
        
        let params = [ProductListingParameter.productCategoryId.description: productCateoryId, ProductListingParameter.limit.description: 10, ProductListingParameter.page.description: 1]
        
        APIManager.sharedInstance.performRequest(serviceType: .getProductList(parameters: params)) { response in
            
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData = jsonProductDecoder(jsonData: content)
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


