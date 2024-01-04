//
//  AutoCompleteComponents.swift
//  BarikoiLocallyTest
//
//  Created by Md. Faysal Ahmed on 8/12/23.
//

import SwiftUI

struct AutoCompleteComponent: View {
    
    @Binding var place: Place
    var didTapCell: (Place) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                didTapCell(place)
                
            }, label: {
                VStack(alignment: .leading, spacing: 10) {
                    Text(place.address)
                        .font(Font.system(size: 14))
                        .lineLimit(1)
                        .foregroundColor(.black)
                    
                    Text(place.area)
                        .font(Font.system(size: 11))
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
            })
        }
        .frame(width: .infinity)
        .colorScheme(.light)
    }
}
