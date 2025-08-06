//
//  PlaceModel.swift
//
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import Foundation

// MARK: - UserDetailsModel
struct PlaceModel: Codable {
    let places: [Place]
    let status: Int
}

public struct Place: Codable, Hashable {
    public let id: Int
    public let longitude: String
    public let latitude: String
    public var address: String
    public let address_bn: String?
    public let city: String
    public let city_bn: String?
    public var area: String
    public let area_bn: String?
    public let postCode: StringOrInt?
    public let pType: String
    public let uCode: String
}

public struct StringOrInt: Codable, Hashable {
    let value: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intVal = try? container.decode(Int.self) {
            self.value = String(intVal)
        }else if let strVal = try? container.decode(String.self) {
            self.value = strVal
        }else {
            throw DecodingError.typeMismatch(
                String.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Inconsistant json for postCode. Can be string or int")
            )
        }
        
    }
    
}

public struct AddressModel {
    let address: String
    let area: String
    let city: String
}
