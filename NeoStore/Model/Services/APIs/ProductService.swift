//
//  ProductList.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

class ProductService{
    static func getProductListing(productCateoryId: Int, completion: @escaping(APIResponse<jsonProductResponse>)->Void){
        
        let params = [ProductListingParameter.productCategoryId.description: 1, ProductListingParameter.limit.description: 10, ProductListingParameter.page.description: 1]
        
        APIManager.sharedInstance.performRequest(serviceType: .getProductList(parameters: params)) { response in
            
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        debugPrint(content)
                        guard let productData = JsonParser.processResponse(result: content, type: jsonProductResponse.self) else{ return }
                        let responseData: APIResponse<jsonProductResponse> = .success(value: productData)
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


