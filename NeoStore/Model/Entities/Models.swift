//
//  Models.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

struct userDetails{
    let firstname: String
    let lastname: String
    let email: String
    let password: String
    let confirmPassword: String
    let gender: String
    let phoneNumber: Int
}

struct userAccountDetails{
    let firstname: String
    let lastname: String
    let profileImage: String
    let email: String
    let dob: String
    let phoneNo: String
}

struct jsonDataResponse{
//    JSON data response format
    let status: Int?
    let data: userResponse?
    let message: String?
    let userMessage: String?
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
        case message = "message"
        case userMessage = "user_msg"
    }
}



struct userResponse{
    let id: Int?
    let roleId: Int?
    let firstname: String?
    let lastname: String?
    let email: String?
//    var username: String{ return self.firstname + " " + self.lastname }
    let username: String?
    let gender: String?
    let phoneNo: Int?
    let isActive: Bool?
    let created: Date?
    let modified: Date?
    let accessToken: String?
    
    enum codingKeys: String, CodingKey{
        case id = "id"
        case roleId = "role_id"
        case firstname = "first_name"
        case lastname = "last_name"
        case email = "email"
        case username = "username"
        case gender = "gender"
        case phoneNo = "phone_no"
        case isActive = "is_active"
        case created = "created"
        case modified = "modified"
        case accessToken = "access_token"
    }
}

extension jsonDataResponse: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        status = try codingKeysValue.decode(Int.self, forKey: .status)
        data = try codingKeysValue.decode(userResponse.self, forKey: .data)
        message = try codingKeysValue.decode(String.self, forKey: .message)
        userMessage = try codingKeysValue.decode(String.self, forKey: .userMessage)
    }
}

extension userResponse: Encodable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(roleId, forKey: .roleId)
        try container.encode(firstname, forKey: .firstname)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(email, forKey: .email)
        try container.encode(username, forKey: .username)
        try container.encode(gender, forKey: .gender)
        try container.encode(phoneNo, forKey: .phoneNo)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(created, forKey: .created)
        try container.encode(modified, forKey: .modified)
        try container.encode(accessToken, forKey: .accessToken)
    }
}

extension userResponse: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        roleId = try codingKeysValue.decode(Int.self, forKey: .roleId)
        firstname = try codingKeysValue.decode(String.self, forKey: .firstname)
        lastname = try codingKeysValue.decode(String.self, forKey: .lastname)
        email = try codingKeysValue.decode(String.self, forKey: .email)
        username = try codingKeysValue.decode(String.self, forKey: .username)
        gender = try codingKeysValue.decode(String.self, forKey: .gender)
        phoneNo = try codingKeysValue.decode(Int.self, forKey: .phoneNo)
        isActive = try codingKeysValue.decode(Bool.self, forKey: .isActive)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
        modified = try codingKeysValue.decode(Date.self, forKey: .modified)
        accessToken = try codingKeysValue.decode(String.self, forKey: .accessToken)
    }
}

struct ProductListModel{
    let productCategoryId: String
    let limit: Int
    let page: Int
}
