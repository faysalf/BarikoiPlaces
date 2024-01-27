//
//  AutoCompleteViewModel.swift
//  BarikoiLocallyTest
//
//  Created by Md. Faysal Ahmed on 8/12/23.
//

import SwiftUI

class AutoCompleteViewModel: ObservableObject {
    
    static let shared = AutoCompleteViewModel()
    
    @Published var placesArr: [Place] = []
    @Published var selectedPlace: PlaceModel?
    @Published var shouldAnimatingIndicator = false
    @Published var goForNextApiCall = true
    
    public func getAutocompletePlaces(_ apiKey: String, _ query: String) {

        shouldAnimatingIndicator = true

        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: "https://barikoi.xyz/v2/api/search/autocomplete/place?api_key=\(apiKey)&q=\(query)&bangla=true")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if goForNextApiCall {
                self.goForNextApiCall = false
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        self.shouldAnimatingIndicator = false
                        self.goForNextApiCall = true
                    }
                    
                    guard let data = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        let placesData = try decoder.decode(PlaceModel.self, from: data)
                        DispatchQueue.main.async {
                            self.placesArr = placesData.places
                        }
                    }catch {
                        if let responseString = String(data: data, encoding: .utf8) {
                            print(responseString)
                        }
                        print(error)
                    }
                }
                task.resume()
            }
        }
    }
    
}

