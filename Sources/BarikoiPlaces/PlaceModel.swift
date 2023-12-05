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
    let id: Int
    let longitude: String
    let latitude: String
    let address: String
    let address_bn: String?
    let city: String
    let city_bn: String?
    let area: String
    let area_bn: String?
    let postCode: Int
    let pType: String
    let uCode: String
}
