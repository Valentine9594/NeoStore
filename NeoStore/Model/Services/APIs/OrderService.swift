//
//  OrderService.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

class OrderService{
    static func fetchOrderList(completion: @escaping(APIResponse<OrderListResponse>)->Void){
        APIManager.sharedInstance.performRequest(serviceType: .getOrderList) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<OrderListResponse> = jsonProductDecoder(jsonData: content)
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
    
    static func fetchOrderDetails(orderId: Int, completion: @escaping(APIResponse<OrderDetailResponse>)->Void){
        
        let params = ["order_id": "\(orderId)"]
        APIManager.sharedInstance.performRequest(serviceType: .getOrderDetail(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<OrderDetailResponse> = jsonProductDecoder(jsonData: content)
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
    
    static func placeOrderAtAddress(address: String, completion: @escaping(APIResponse<PlaceOrderResponse>)->Void){
        let params = ["address": address]
        
        APIManager.sharedInstance.performRequest(serviceType: .placeOrder(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<PlaceOrderResponse> = jsonProductDecoder(jsonData: content)
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
