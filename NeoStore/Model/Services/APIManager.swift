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
            if serviceType.method == "POST"{
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = params.map{
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                request.httpBody = requestBodyComponents.query?.data(using: .utf8)
            }
            else{
                var urlComponents = URLComponents(string: serviceType.path)
                urlComponents?.queryItems = params.map{
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                request.url = urlComponents?.url
            }
        }
        
        request.allHTTPHeaderFields = serviceType.headers as? AnyDictString
        let task = session.dataTask(with: request as URLRequest){
            data, response, error in
            
            guard error == nil else{
                completionHandler(.failure(error: error!))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else{ return }
            guard [200, 400, 401, 404, 500].contains(httpResponse.statusCode) else{
                completionHandler(.failure(error: CustomErrors.SometingWentWrong))
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
