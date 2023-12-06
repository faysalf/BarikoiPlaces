//
//  BarikoiPlacesClient.swift
//  
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import Foundation

internal struct BarikoiPlacesClient {
    
    private static var userApiKey: String?
    
//    public init(apiKey: String) {
//        self.apiKey = apiKey
//    }
    
    // set api key
    internal static func myApiKey(_ apiKey: String) {
        userApiKey = apiKey
    }
    
    static func getApiKey() -> String {
        guard let apiKey = userApiKey, !apiKey.isEmpty else { return "" }
        return apiKey
    }
    
}
