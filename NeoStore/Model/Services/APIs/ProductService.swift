//
//  ProductList.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

class ProductService{
    static func getProductLists(){
        APIManager.sharedInstance.performRequest(serviceType: .getProductList) { response in
            
            switch response{
                case .success(let data):

                    print(data)
                    print("Successfully recieved JSON data.")
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
}


