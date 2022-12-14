//
//  Utils.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.12.2022.
//

import Foundation
import UIKit

final class DateUtils {
    
    static let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
}

struct Utils {
    
    static func configButton() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.titlePadding = 8.0
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        config.titleAlignment = .center
        config.baseBackgroundColor = UIColor(red: 0.18, green: 0.45, blue: 0.20, alpha: 0.55)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        return config
    }
}

extension UIImage {
    
    var toData: Data? {
        return pngData()
    }
}
