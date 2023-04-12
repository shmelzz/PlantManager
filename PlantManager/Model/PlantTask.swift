//
//  Task.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import Foundation

enum PlantAction: String, Codable {
    case water
    case cut
    case fertilize
    case repot
}

struct PlantTask: FirebaseIdentifiable {
    var id: String
    var userId: String
    var plantId: String
    var plantName: String
    var completed = false
    var reminderDay: Date
    var taskType: PlantAction
}

