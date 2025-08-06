//
//  File.swift
//
//
//  Created by Md. Faysal Ahmed on 7/12/23.
//

import UIKit

class Indicator {
    
    static let shared: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        }
        
        indicator.color = .gray
        indicator.backgroundColor = .clear
        let width = UIScreen.main.bounds.width, height = UIScreen.main.bounds.height
        let indicatorSz = 100.0
        indicator.frame = CGRect(x: (width-indicatorSz)/2, y: 300, width: indicatorSz, height: indicatorSz)
        indicator.layer.cornerRadius = 10.0
        return indicator
    }()
    
    
}
