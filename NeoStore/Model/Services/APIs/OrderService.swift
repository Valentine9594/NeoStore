//
//  OrderService.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

class OrderService{
    static func fetchOrderList(completion: @escaping(APIResponse<OrderListResponse<OrderListData>>)->Void){
        APIManager.sharedInstance.performRequest(serviceType: .getOrderList) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<OrderListResponse<OrderListData>> = jsonProductDecoder(jsonData: content)
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
    
    static func fetchOrderDetails(orderId: Int, completion: @escaping(APIResponse<OrderListResponse<OrderDetail>>)->Void){
        
        let params = ["order_id": orderId]
        APIManager.sharedInstance.performRequest(serviceType: .getOrderDetail(parameters: params)) { (response) in
            switch response{
                case .success(let data):
                    if let content = data as? Data{
                        let responseData: APIResponse<OrderListResponse<OrderDetail>> = jsonProductDecoder(jsonData: content)
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
