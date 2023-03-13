//
//  PlantType.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import Foundation
import UIKit

enum PlantAction {
    case water
    case cut
    case fertilize
    case repot
}

struct Room {
    let name: String
}

struct PlantType {
    
//    enum PlantAverageSize {
//        case small
//        case medium
//        case large
//    }
//
    let title: String
    // let size: PlantAverageSize
}

struct Plant {
    var name: String
    var plantType: PlantType
    var place: Room
    var purchaseDay: Date
    var wateringSpan: Int
    var image: UIImage?
}
