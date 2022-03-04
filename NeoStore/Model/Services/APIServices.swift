//
//  APIServices.swift
//  NeoStore
//
//  Created by neosoft on 01/02/22.
//

import Foundation

typealias AnyDict = [String:Any]
typealias AnyDictString = [String:String]

let DEV_ROOT_POINT = "http://staging.php-dev.in:8844/trainingapp"
let PROD_ROOT_POINT = "https://api.com"

//let contentValue = "application/json"
let contentValue = "application/x-www-form-urlencoded"
let contentKey = "Content-Type"

enum NetworkEnvironment: String{
    case development
    case production
}

var networkEnvironment: NetworkEnvironment{
    return .development
}

var BaseURL: String{
    switch networkEnvironment {
        case .development:
            return DEV_ROOT_POINT
        case .production:
            return PROD_ROOT_POINT
    }
}

enum APIServices{
    public struct subDomain{
        static let apiDomain = "/api/"
    }
    
    case userLogin(parameters: AnyDict)
    case userRegister(parameters: AnyDict)
    case forgotPassword(parameters: AnyDict)
    case changePassword(parameters: AnyDict)
    case updateAccount(parameters: AnyDict)
    case getUserDetails
    case getProductList(parameters: AnyDict)
    case getProductDetails(parameters: AnyDict)
    case setProductRatings(paramters: AnyDict)
    case addToCart(paramters: AnyDict)
    case editCart(paramters: AnyDict)
    case deleteCart(paramters: AnyDict)
    case getCartList
    case placeOrder(paramters: AnyDict)
    case getOrderList
    case getOrderDetail
}

extension APIServices{
    
    var path: String {
        let serviceDomain = subDomain.apiDomain
        
        var servicePath: String = ""
        switch self {
            case .userLogin: servicePath = serviceDomain + "users/login"
            case .userRegister: servicePath = serviceDomain + "users/register"
            case .forgotPassword: servicePath = serviceDomain + "users/forgot"
            case .changePassword: servicePath = serviceDomain + "users/change"
            case .updateAccount: servicePath = serviceDomain + "users/update"
            case .getUserDetails: servicePath = serviceDomain + "users/getUserData"
            case .getProductList: servicePath = serviceDomain + "products/getList"
            case .getProductDetails: servicePath = serviceDomain + "products/getDetail"
            case .setProductRatings: servicePath = serviceDomain + "products/setRating"
            case .addToCart: servicePath = serviceDomain + "addToCart"
            case .editCart: servicePath = serviceDomain + "editCart"
            case .deleteCart: servicePath = serviceDomain + "deleteCart"
            case .getCartList: servicePath = serviceDomain + "cart"
            case .placeOrder: servicePath = serviceDomain + "order"
            case .getOrderList: servicePath = serviceDomain + "orderList"
            case .getOrderDetail: servicePath = serviceDomain + "orderDetail"
        }
        
        return BaseURL + servicePath
    }
    
    var parameters: AnyDict?{
        switch self {
            case .userRegister(let param), .userLogin(let param), .updateAccount(let param), .setProductRatings(let param), .placeOrder(let param), .forgotPassword(let param), .changePassword(let param), .addToCart(let param), .editCart(let param), .deleteCart(let param), .getProductList(let param), .getProductDetails(let param):
                return param
            default:
                return nil
        }
    }
    
    var headers: AnyDict{
        var headerDict = AnyDictString()
        headerDict[contentKey] = contentValue
        
        switch self{
            case .changePassword(_), .getUserDetails, .updateAccount(_), .addToCart(_), .getCartList, .editCart(_), .deleteCart(_):
                let currentAccessToken = getDataFromUserDefaults(key: .accessToken) ?? "NO TOKEN"
                headerDict = [contentKey: contentValue, UserDefaultsKeys.accessToken.description: currentAccessToken]
            default:
                break
        }
        return headerDict
    }
    
    var method: String{
        switch self {
            case .getUserDetails, .getProductList, .getProductDetails, .getOrderList, .getOrderDetail, .getCartList:
                return "GET"
            default:
                return "POST"
        }
    }
    
}
