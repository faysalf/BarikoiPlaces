//
//  AutoCompleteViewSiwftUI.swift
//
//
//  Created by Md. Faysal Ahmed on 8/12/23.
//

import SwiftUI

public struct AutoCompleteViewSiwftUI: View {
    
    @ObservedObject var vm = AutoCompleteViewModel.shared
    @State var searchText = ""
    public var dismissAction: () -> Void
    public var didTapPlace: (Place) -> Void
    
    public init(dismissAction: @escaping () -> Void, didTapPlace: @escaping (Place) -> Void) {
        self.dismissAction = dismissAction
        self.didTapPlace = didTapPlace
    }

    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(alignment: .center, spacing: 5) {
                    TextField("Search Location...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .onChange(of: searchText) { newText in
                            if newText.count >= 3 {
                                vm.getAutocompletePlaces(newText)
                            }else {
                                vm.placesArr = []
                            }
                        }
                    
                    Button(action: {
                        dismissAction()
                        
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                            .font(Font.system(size: 15))
                    })
                    
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach($vm.placesArr, id: \.self) { place in
                            AutoCompleteComponent(place: place, didTapCell: { selectedPlace in
                                didTapPlace(selectedPlace)
                                dismissAction()
                            })
                            
                            Divider()
                                .background(Color.gray)
                                .frame(height: 1.0)
                        }
                        
                    }
                }
            }
            .padding()
            
            if vm.shouldAnimatingIndicator {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                    .scaleEffect(2.0)
            }
        }
        
    }
}

struct YourView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = AutoCompleteViewModel.shared
        vm.placesArr = getArr()
        
        return AutoCompleteViewSiwftUI(dismissAction: {}, didTapPlace: {_ in })
            .environmentObject(vm)
    }
}





func getArr() -> [Place] {
    var arr = [Place]()
    
    for i in 0..<20 {
        arr.append(Place(id: 517322, longitude: "90.369973182678", latitude: "23.756163746007", address: "Lalmatia, Lalmatia, Dhaka", address_bn: Optional("লালমাটিয়া, লালমাটিয়া, ঢাকা"), city: "Dhaka", city_bn: Optional("ঢাকা"), area: "Lalmatia", area_bn: Optional("লালমাটিয়া"), postCode: 1207, pType: "Admin", uCode: "PQOJ2492"))
    }
    return arr
}
