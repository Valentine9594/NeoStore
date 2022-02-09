//
//  JSONParser.swift
//  NeoStore
//
//  Created by neosoft on 09/02/22.
//

import Foundation

struct JsonParser{
    static func processResponse<T:Decodable>(result: Data?, type: T.Type) -> T?{
        if let response = result{
            do {
                return try type.decode(data: response)
            } catch {}
        }
        return nil
    }
}

extension Decodable{
    static func decode(data: Data) throws -> Self{
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable{
    func encode() throws -> Data{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}

func convertModelToJSON<T: Codable>(model: T) -> AnyDict?{
    do {
        let data = try JSONEncoder().encode(model)
        let object = try JSONSerialization.jsonObject(with: data)
        return object as? AnyDict
    } catch {
        return nil
    }
}
