//
//  Constants.swift
//  NeoStore
//
//  Created by neosoft on 01/02/22.
//

import Foundation

enum APIResponse<T>{
    case success(value: T)
    case failure(error: Error)
}


