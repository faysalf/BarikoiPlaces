//
//  BarikoiPlacesClient.swift
//
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import UIKit

public struct BarikoiPlacesClient {
    
    private static var userApiKey: String?
    
    // set api key
    public static func myApiKey(_ apiKey: String) {
        userApiKey = apiKey
    }
    
    static func getApiKey() -> String {
        guard let apiKey = userApiKey, !apiKey.isEmpty else { return "" }
        return apiKey
    }
    
}


extension UIApplication {
    static var topSafeAreaHeight: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
         if #available(iOS 11.0, *) {
               let window = UIApplication.shared.windows[0]
               let safeFrame = window.safeAreaLayoutGuide.layoutFrame
               topSafeAreaHeight = safeFrame.minY
             }
        return topSafeAreaHeight
    }
}
