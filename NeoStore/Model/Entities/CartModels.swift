//
//  MyCartModels.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

struct CartData{
    let status: Int?
    let data: Bool?
    let totalCarts: Int?
    let message: String?
    let userMessage: String?
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
        case totalCarts = "total_carts"
        case message = "message"
        case userMessage = "user_msg"
    }
}

extension CartData: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        status = try codingKeysValue.decode(Int.self, forKey: .status)
        data = try codingKeysValue.decode(Bool.self, forKey: .data)
        totalCarts = try codingKeysValue.decode(Int.self, forKey: .totalCarts)
        message =  try codingKeysValue.decode(String.self, forKey: .message)
        userMessage = try codingKeysValue.decode(String.self, forKey: .userMessage)
    }
}


struct CartListResponse{
    let status: Int?
    let data: [CartListProductData]?
    let count: Int?
    let total: Int?
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
        case count = "count"
        case total = "total"
    }
}

extension CartListResponse: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        status = try codingKeysValue.decode(Int.self, forKey: .status)
        data = try codingKeysValue.decode([CartListProductData].self, forKey: .data)
        count = try codingKeysValue.decode(Int.self, forKey: .count)
        total = try codingKeysValue.decode(Int.self, forKey: .total)
    }
}

struct CartListProductData{
    let id: Int?
    let productId: Int?
    let quantity: Int?
    let product: CartListProductDetails?
    
    enum codingKeys: String, CodingKey{
        case id
        case productId = "product_id"
        case quantity = "quantity"
        case product = "product"
    }
}

extension CartListProductData: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        productId = try codingKeysValue.decode(Int.self, forKey: .productId)
        quantity = try codingKeysValue.decode(Int.self, forKey: .quantity)
        product = try codingKeysValue.decode(CartListProductDetails.self, forKey: .product)
    }
}

struct CartListProductDetails{
    let id: Int?
    let name: String?
    let cost: Int?
    let productCategory: String?
    let productImage: String?
    let subTotal: Int?
    
    enum codingKeys: String, CodingKey{
        case id
        case name = "name"
        case cost = "cost"
        case productCategory = "product_category"
        case productImage = "product_images"
        case subTotal = "sub_total"
    }
}

extension CartListProductDetails: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        name = try codingKeysValue.decode(String.self, forKey: .name)
        cost = try codingKeysValue.decode(Int.self, forKey: .cost)
        productCategory = try codingKeysValue.decode(String.self, forKey: .productCategory)
        productImage = try codingKeysValue.decode(String.self, forKey: .productImage)
        subTotal = try codingKeysValue.decode(Int.self, forKey: .subTotal)
    }
}
