//
//  BarikoiPlacesClient.swift
//  
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import Foundation

class BarikoiPlacesClient {
    
    private var apiKey: String?
    
//    public init(apiKey: String) {
//        self.apiKey = apiKey
//    }
    
    // set api key
    public func myApiKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func getApiKey() -> String {
        guard let apiKey = apiKey, !apiKey.isEmpty else { return "" }
        return apiKey
    }
    
    
}
