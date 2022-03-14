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
    let profileImage: String?
    let email: String
    let dob: String?
    let phoneNo: String
}

struct jsonDataResponse<T: Decodable>{
//    JSON data response format
    let status: Int?
    let data: T?
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
    let phoneNo: String?
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
        data = try codingKeysValue.decode(T.self, forKey: .data)
        message = try codingKeysValue.decode(String.self, forKey: .message)
        userMessage = try codingKeysValue.decode(String.self, forKey: .userMessage)
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
        phoneNo = try codingKeysValue.decode(String.self, forKey: .phoneNo)
        isActive = try codingKeysValue.decode(Bool.self, forKey: .isActive)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
        modified = try codingKeysValue.decode(Date.self, forKey: .modified)
        accessToken = try codingKeysValue.decode(String.self, forKey: .accessToken)
    }
}
