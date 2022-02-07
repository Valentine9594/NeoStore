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

struct userDetails{
    let firstname: String
    let lastname: String
    let email: String
    let password: String
    let confirmPassword: String
    let gender: String
    let phoneNumber: Int
}

