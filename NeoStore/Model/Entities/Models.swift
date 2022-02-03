//
//  Models.swift
//  NeoStore
//
//  Created by neosoft on 02/02/22.
//

import Foundation

struct ProductListModel{
    let productCategoryId: String
    let limit: Int
    let page: Int
}

struct jsonDataAny{
    let status: Int
    let data: Any
    let message: String
    let userMessage: String
}

struct UserLoginDetails{
    let id: Int
    let roleId: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let gender: String
    let phoneNo: String
    let isActive: Bool
    let created: Date
    let modified: Date
    let accessToken: String
}
