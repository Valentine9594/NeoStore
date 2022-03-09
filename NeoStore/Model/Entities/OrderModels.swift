//
//  OrderModels.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

struct OrderListResponse{
    let status: Int?
    let data: [OrderListData]?
    let message: String?
    let userMessage: String?
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
        case message = "message"
        case userMessage = "user_msg"
    }
}

extension OrderListResponse: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        status = try codingKeysValue.decode(Int.self, forKey: .status)
        data = try codingKeysValue.decode([OrderListData].self, forKey: .data)
        message = try codingKeysValue.decode(String.self, forKey: .message)
        userMessage = try codingKeysValue.decode(String.self, forKey: .userMessage)
    }
}

struct OrderListData{
    let id: Int?
    let cost: Int?
    let created: Date?
    
    enum codingKeys: String, CodingKey{
        case id
        case cost = "cost"
        case created = "created"
    }
}

extension OrderListData: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        cost =  try codingKeysValue.decode(Int.self, forKey: .cost)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
    }
}

struct OrderDetailResponse{
    let status: Int?
    let data: OrderDetail?
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
    }
}

extension OrderDetailResponse: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        status = try codingKeysValue.decode(Int.self, forKey: .status)
        data = try codingKeysValue.decode(OrderDetail.self, forKey: .data)
    }
}

struct OrderDetail{
    let id: Int?
    let cost: Int?
    let address: String?
    let orderDetails: [OrderDetailsData]?
    
    enum codingKeys: String, CodingKey{
        case id = "id"
        case cost = "cost"
        case address = "address"
        case orderDetails = "order_details"
    }
}

extension OrderDetail: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        cost =  try codingKeysValue.decode(Int.self, forKey: .cost)
        address = try codingKeysValue.decode(String.self, forKey: .address)
        orderDetails = try codingKeysValue.decode([OrderDetailsData].self, forKey: .orderDetails)
    }
}

struct OrderDetailsData{
    let id: Int?
    let orderId: Int?
    let productId: Int?
    let quantity: Int?
    let total: Int?
    let productName: String?
    let productCategoryName: String?
    let productImage: String?
    
    enum codingKeys: String, CodingKey{
        case id
        case orderId = "order_id"
        case productId = "product_id"
        case quantity = "quantity"
        case total = "total"
        case productName = "prod_name"
        case productCategoryName = "prod_cat_name"
        case productImage = "prod_image"
    }
}

extension OrderDetailsData: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        orderId = try codingKeysValue.decode(Int.self, forKey: .orderId)
        productId = try codingKeysValue.decode(Int.self, forKey: .productId)
        quantity = try codingKeysValue.decode(Int.self, forKey: .quantity)
        total = try codingKeysValue.decode(Int.self, forKey: .total)
        productName = try codingKeysValue.decode(String.self, forKey: .productName)
        productCategoryName = try codingKeysValue.decode(String.self, forKey: .productCategoryName)
        productImage = try codingKeysValue.decode(String.self, forKey: .productImage)
    }
}
