//
//  CartService.swift
//  NeoStore
//
//  Created by neosoft on 02/03/22.
//

import Foundation

class CartService{
    static func addToCart(productId: Int, quantity: Int, completion: @escaping(APIResponse<CartData>)->Void){
        
        let params = ["product_id": productId, "quantity": quantity]
        
        APIManager.sharedInstance.performRequest(serviceType: .addToCart(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<CartData> = jsonProductDecoder(jsonData: content)
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
    
    static func fetchCart(completion: @escaping(APIResponse<CartListResponse>)->Void){
        APIManager.sharedInstance.performRequest(serviceType: .getCartList) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<CartListResponse> = jsonProductDecoder(jsonData: content)
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
    
    static func deleteFromCart(productId: Int, completion: @escaping(APIResponse<CartData>)->Void){
        let params = ["product_id": productId]
        
        APIManager.sharedInstance.performRequest(serviceType: .deleteCart(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<CartData> = jsonProductDecoder(jsonData: content)
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
    
    static func editCart(productId: Int, quantity: Int, completion: @escaping(APIResponse<CartData>)->Void){
        let params = ["product_id": productId, "quantity": quantity]
        
        APIManager.sharedInstance.performRequest(serviceType: .editCart(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<CartData> = jsonProductDecoder(jsonData: content)
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
