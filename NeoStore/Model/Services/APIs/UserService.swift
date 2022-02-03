//
//  UserService.swift
//  NeoStore
//
//  Created by neosoft on 03/02/22.
//

import Foundation

class UserService{
    
    static func userLogIn(params: AnyDict){
        
        APIManager.sharedInstance.performRequest(serviceType: .userLogin(parameters: params), completion: (APIResponse<String>)->Void){
            (response) in
            switch response{
                case .success(let data):
//                    print(data)
                    do {
                        var json = try? JSONSerialization.jsonObject(with: data, options: [])
                        completion(.success(value: json))
                    } catch let error {
                        debugPrint(error.localizedDescription)
                        completion(.failure(error: error))
                    }

                    print("Success on Login!")
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error: error))
            }
            
        }
    }
}
