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

public struct Place: Codable {
    public let id: Int
    public let longitude: String
    public let latitude: String
    public let address: String
    public let address_bn: String?
    public let city: String
    public let city_bn: String?
    public let area: String
    public let area_bn: String?
    public let postCode: Int
    public let pType: String
    public let uCode: String
}
