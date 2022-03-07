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
