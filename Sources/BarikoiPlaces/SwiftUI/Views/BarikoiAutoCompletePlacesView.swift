//
//  AutoCompleteViewSiwftUI.swift
//
//
//  Created by Md. Faysal Ahmed on 8/12/23.
//

import SwiftUI

public struct BarikoiAutoCompletePlacesView: View {
    
    @Environment(\.presentationMode) var placesViewDismiss
    @StateObject var vm = AutoCompleteViewModel()
    @State var searchText = ""
    @State private var initialQuery = ""
    @State private var apiKey = ""
    public var didTapPlace: (Place?) -> Void
    
    public init(apiKey: String, initialQuery: String = "Dhanmondi", didTapPlace: @escaping (Place?) -> Void) {
        self.apiKey = apiKey
        self.initialQuery = initialQuery
        self.didTapPlace = didTapPlace
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(alignment: .center, spacing: 5) {
                    TextField("Search Location...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .onChange(of: searchText) { newText in
                            vm.setSearchQuery(newText)
                        }
                    
                    Button(action: {
                        dismissAction()
                        
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                            .font(Font.system(size: 15, weight: .medium))
                    })
                    
                }
                
                Button(action: {
                    didTapPlace(nil)
                    dismissAction()
                    
                }, label: {
                    Text("Clear Location X")
                        .foregroundColor(.red)
                        .font(Font.system(size: 15, weight: .medium))
                        .padding(10)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(8.0)
                })
                //.buttonStyle(.bordered)
                
                List(vm.places, id: \.id) { place in
                    AutoCompleteComponent(place: place, didTapCell: { selectedPlace in
                        didTapPlace(selectedPlace)
                        dismissAction()
                    })
                }
                .listStyle(.plain)
                
            }
            .padding()
            
//            if vm.shouldAnimatingIndicator {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
//                    .scaleEffect(2.0)
//            }
            
        }
        .colorScheme(.light)
        .background(Color.white)
        .onAppear() {
            self.vm.apiKey = self.apiKey
            self.vm.initialQuery = self.initialQuery
        }
        
    }
    
    func dismissAction() {
        placesViewDismiss.wrappedValue.dismiss()
    }
    
}

func getArr() -> [Place] {
    var arr = [Place]()
    
    for i in 0..<20 {
        arr.append(Place(id: 517322+i, longitude: "90.369973182678", latitude: "23.756163746007", address: "Lalmatia, Lalmatia, Dhaka", address_bn: Optional("লালমাটিয়া, লালমাটিয়া, ঢাকা"), city: "Dhaka", city_bn: Optional("ঢাকা"), area: "Lalmatia", area_bn: Optional("লালমাটিয়া"), postCode: nil, pType: "Admin", uCode: "PQOJ2492"))
    }
    return arr
}
