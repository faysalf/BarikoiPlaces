//
//  PlacesViewModel.swift
//  BarikoiPlaces
//
//  Created by Vector360 BD on 4/8/25.
//

import UIKit
import Combine

class PlacesViewModel {
    
    @Published var places: [Place] = []
    let errorPurblisher = PassthroughSubject<String, Never>()
    var indicatorLoading = PassthroughSubject<Bool, Never>()
    var shouldEmptyViewShows = PassthroughSubject<Bool, Never>()
    var addressQuerySubject = CurrentValueSubject<String, Never>("")
    var cancellables: Set<AnyCancellable> = []
    var initialQuery: String = "Dhanmondi"
    
    init() {
        setupSearchPublisher()
    }
    
    func setAddressQuery(_ query: String) {
        addressQuerySubject.send(query)
    }
    
    private func setupSearchPublisher() {
        addressQuerySubject
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                guard let self else { return }
                if searchText != "" {
                    getAutocompletePlaces(searchText)
                }else {
                    getAutocompletePlaces(initialQuery)
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func getAutocompletePlaces(_ query: String) {
        let apiKey = BarikoiPlacesClient.getApiKey()
        guard !apiKey.isEmpty else { return }
        indicatorLoading.send(true)
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://barikoi.xyz/v2/api/search/autocomplete/place?api_key=\(apiKey)&q=\(encodedQuery)&bangla=true") else {
            indicatorLoading.send(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PlaceModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                indicatorLoading.send(false)
                
                if case let .failure(error) = completion {
                    debugPrint("Error: \(error)")
                    errorPurblisher.send(error.localizedDescription)
                }
            } receiveValue: { [weak self] placesData in
                self?.places = placesData.places
                
            }
            .store(in: &cancellables)
        
    }
    
    
}
