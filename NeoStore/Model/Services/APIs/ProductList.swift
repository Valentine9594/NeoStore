//
//  ProductList.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

class ProductList{
    static func getProductLists(){
        
        APIManager.sharedInstance.performRequest(serviceType: .getProductList){
            (response) in
            
            switch response{
                case .success(let data):
//                    do {
//                        if let content = try JSONSerialization.jsonObject(with: data, options: []){
//                            print(content)
//                        }
//                    } catch let error as NSError {
//                        debugPrint(error.localizedDescription)
//                    }
                    print(data)
                    print("Successfully recieved JSON data.")
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
}

//class UserLogin{
//    static func logUserIn(){
//
//        APIManager.sharedInstance.performRequest(serviceType: .getProductList){
//            (response) in
//
//            switch response{
//                case .success(let data):
////                    do {
////                        let someData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
////                        print(data)
////                    } catch let error {
////                        print("No Data")
////                    }
//                print(data)
//                    print("Successfully recieved JSON data.")
//                case .failure(let error):
//                    debugPrint(error.localizedDescription)
//            }
//        }
//    }
//}
