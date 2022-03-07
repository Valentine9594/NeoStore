//
//  ProductModels.swift
//  NeoStore
//
//  Created by neosoft on 07/03/22.
//

import Foundation

enum ProductListingParameter: String{
    case productCategoryId = "product_category_id"
    case limit = "limit"
    case page =  "page"
    case productId = "product_id"
    
    var description: String{
        rawValue
    }
}

struct jsonProductResponse<T: Decodable>{
    let status: Int?
    let data: T
    
    enum codingKeys: String, CodingKey{
        case status = "status"
        case data = "data"
    }
    
}

extension jsonProductResponse: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        status = try codingKeysValue.decode(Int.self, forKey: .status)
        data = try codingKeysValue.decode(T.self, forKey: .data)
    }
}

struct ProductData{
    let id: Int?
    let productCategoryId: Int?
    let name: String?
    let producer: String?
    let description: String?
    let cost: Int?
    let rating: Int?
    let viewCount: Int?
    let productImages: String?
    let created: Date?
    let modified: Date?
    
    enum codingKeys: String, CodingKey{
        case id
        case productCategoryId = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case viewCount = "view_count"
        case productImages = "product_images"
        case created = "created"
        case modified = "modified"
    }
}

extension ProductData: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        productCategoryId = try codingKeysValue.decode(Int.self, forKey: .productCategoryId)
        name = try codingKeysValue.decode(String.self, forKey: .name)
        producer = try codingKeysValue.decode(String.self, forKey: .producer)
        description = try codingKeysValue.decode(String.self, forKey: .description)
        cost = try codingKeysValue.decode(Int.self, forKey: .cost)
        rating = try codingKeysValue.decode(Int.self, forKey: .rating)
        viewCount = try codingKeysValue.decode(Int.self, forKey: .viewCount)
        productImages = try codingKeysValue.decode(String.self, forKey: .productImages)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
        modified = try codingKeysValue.decode(Date.self, forKey: .modified)
    }
}

struct ProductDetails{
    let id: Int?
    let productCategoryId: Int?
    let name: String?
    let producer: String?
    let description: String?
    let cost: Int?
    let rating: Int?
    let viewCount: Int?
    let productImages: [ProductImagesCollection]?
    let created: Date?
    let modified: Date?
    
    enum codingKeys: String, CodingKey{
        case id
        case productCategoryId = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case viewCount = "view_count"
        case productImages = "product_images"
        case created = "created"
        case modified = "modified"
    }
}

extension ProductDetails: Decodable{
    init(from decoder: Decoder) throws {
        
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        productCategoryId = try codingKeysValue.decode(Int.self, forKey: .productCategoryId)
        name = try codingKeysValue.decode(String.self, forKey: .name)
        producer = try codingKeysValue.decode(String.self, forKey: .producer)
        description = try codingKeysValue.decode(String.self, forKey: .description)
        cost = try codingKeysValue.decode(Int.self, forKey: .cost)
        rating = try codingKeysValue.decode(Int.self, forKey: .rating)
        viewCount = try codingKeysValue.decode(Int.self, forKey: .viewCount)
        productImages = try codingKeysValue.decode([ProductImagesCollection].self, forKey: .productImages)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
        modified = try codingKeysValue.decode(Date.self, forKey: .modified)
    }
}

struct ProductImagesCollection{
    let id: Int?
    let productId: Int?
    let productImages: String?
    let created: Date?
    let modified: Date?
    
    enum codingKeys: String, CodingKey{
        case id
        case productId = "product_id"
        case productImages = "image"
        case created = "created"
        case modified = "modified"
    }
}

extension ProductImagesCollection: Decodable{
    init(from decoder: Decoder) throws {
        
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        productId = try codingKeysValue.decode(Int.self, forKey: .productId)
        productImages = try codingKeysValue.decode(String.self, forKey: .productImages)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
        modified = try codingKeysValue.decode(Date.self, forKey: .modified)
    }
}

struct ProductRatingResponseData{
    let id: Int?
    let productCategoryId: Int?
    let name: String?
    let producer: String?
    let description: String?
    let cost: Int?
    let rating: Float?
    let viewCount: Int?
    let created: Date?
    let modified: Date?
    
    enum codingKeys: String, CodingKey{
        case id
        case productCategoryId = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case viewCount = "view_count"
        case created = "created"
        case modified = "modified"
    }
}

extension ProductRatingResponseData: Decodable{
    init(from decoder: Decoder) throws {
        let codingKeysValue = try decoder.container(keyedBy: codingKeys.self)
        id = try codingKeysValue.decode(Int.self, forKey: .id)
        productCategoryId = try codingKeysValue.decode(Int.self, forKey: .productCategoryId)
        name = try codingKeysValue.decode(String.self, forKey: .name)
        producer = try codingKeysValue.decode(String.self, forKey: .producer)
        description = try codingKeysValue.decode(String.self, forKey: .description)
        cost = try codingKeysValue.decode(Int.self, forKey: .cost)
        rating = try codingKeysValue.decode(Float.self, forKey: .rating)
        viewCount = try codingKeysValue.decode(Int.self, forKey: .viewCount)
        created = try codingKeysValue.decode(Date.self, forKey: .created)
        modified = try codingKeysValue.decode(Date.self, forKey: .modified)
    }
}
