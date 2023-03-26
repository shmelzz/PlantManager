//
//  Extensions.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import UIKit


extension UIImage {
    var toData: Data? {
        return pngData()
    }
}


// MARK: - extensons
extension UIButton {
    
    public func changeNotSelectedButtonView(title: String) {
        var buttonConfig = Utils.configButton()
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .black
        buttonConfig.title = title
        configuration = buttonConfig
    }
    
    public func changeSelectedButtonView(title: String) {
        var buttonConfig = Utils.configButton()
        buttonConfig.baseBackgroundColor = UIColor(red: 0.18, green: 0.45, blue: 0.20, alpha: 0.55)
        buttonConfig.baseForegroundColor = .white
        buttonConfig.title = title
        configuration = buttonConfig
    }
}

