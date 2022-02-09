//
//  KeyedDecodingContainer + Extension.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import Foundation

extension KeyedDecodingContainer{
    public func decodeSafely<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T?{
        return self.decodeSafely(T.self, forKey: key)
    }
    
    public func decodeSafely<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T?{
        let decoded = try? decode(Safe<T>.self, forKey: key)
        return decoded?.value
    }
    
    public func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T?{
        return self.decodeSafelyIfPresent(T.self, forKey: key)
    }
    
    public func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T?{
        let decoded = try? decodeIfPresent(Safe<T>.self, forKey: key)
        return decoded?.value
    }
}

struct Safe<Base: Decodable>: Decodable{
    let value: Base?
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}
