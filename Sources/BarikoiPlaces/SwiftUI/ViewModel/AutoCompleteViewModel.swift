//
//  AutoCompleteViewModel.swift
//  BarikoiLocallyTest
//
//  Created by Md. Faysal Ahmed on 8/12/23.
//

import SwiftUI
import Combine

class AutoCompleteViewModel: ObservableObject {
    var apiKey: String = ""
    var initialQuery: String = ""
    @Published var places: [Place] = []
    @Published var indicatorLoading = false
    @Published var isErrorOccured = false
    @Published var errorMessage = ""
    
    private var searchQuerySubject = CurrentValueSubject<String, Never>("")
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupSearchPublisher()
    }
    
    func setSearchQuery(_ query: String) {
        searchQuerySubject.send(query)
    }
    
    private func setupSearchPublisher() {
        searchQuerySubject
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink {[weak self] query in
                guard let self else { return }
                if query != "" {
                    getAutocompletePlaces(apiKey, query)
                }else {
                    getAutocompletePlaces(apiKey, initialQuery)
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func getAutocompletePlaces(_ apiKey: String, _ query: String) {
        indicatorLoading = true
        
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: "https://barikoi.xyz/v2/api/search/autocomplete/place?api_key=\(apiKey)&q=\(query)&bangla=true")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: PlaceModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self else { return }
                    indicatorLoading = false
                    
                    if case let .failure(error) = completion {
                        debugPrint("Error: \(error)")
                        errorMessage = error.localizedDescription
                        isErrorOccured = true
                    }
                    
                } receiveValue: { [weak self] placesData in
                    self?.places = placesData.places
                    
                }
                .store(in: &cancellables)
            
        }
        
    }
    
}

