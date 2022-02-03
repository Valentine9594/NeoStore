//
//  APIManager.swift
//  NeoStore
//
//  Created by neosoft on 01/02/22.
//

import Foundation

class APIManager{
    
    static let sharedInstance = APIManager()
    
    private init(){}
    
    public func performRequest(serviceType: APIServices, completionHandler: @escaping(APIResponse<Any>) -> Void){
        
//        Reachability to check network connected or not
        
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: serviceType.path)!)
//        request.cachePolicy = .returnCacheDataElseLoad
        request.httpMethod = serviceType.method
        
        if let params = serviceType.parameters{
            do {
//                let encoder = JSONEncoder()
//                encoder.outputFormatting = .prettyPrinted
//                let jsonData = try encoder.encode(params)
                
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        
        request.allHTTPHeaderFields = serviceType.headers as? AnyDictString
        let task = session.dataTask(with: request as URLRequest){
            data, response, error in
            
            guard error == nil else{
                completionHandler(.failure(error: error!))
                return
            }
            
            guard let someData = data else{
                completionHandler(.failure(error: error!))
                return
            }
            
            do{
                if (try JSONSerialization.jsonObject(with: someData, options: .mutableContainers) as? AnyDict) != nil{
                    completionHandler(.success(value: someData))
//                    print("SUCCESS ON JSON DATA.")
                }
            }
            catch let error{
                debugPrint(error.localizedDescription)
                completionHandler(.failure(error: error))
            }
            
        }
        
        task.resume()
        
        
    }
}
