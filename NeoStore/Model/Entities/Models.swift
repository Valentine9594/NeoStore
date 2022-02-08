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

struct jsonDataResponse: Codable{
    let status: Int
    let data: userResponse
    let message: String
    let userMessage: String
}

struct userResponse: Codable{
    let id: Int
    let roleId: Int
    let firstname: String
    let lastname: String
    let email: String
//    var username: String{ return self.firstname + " " + self.lastname }
    let username: String
    let gender: String
    let phoneNo: Int
    let isActive: Bool
    let created: Date
    let modified: Date
    let accessToken: String
    
}

struct ProductListModel{
    let productCategoryId: String
    let limit: Int
    let page: Int
}
