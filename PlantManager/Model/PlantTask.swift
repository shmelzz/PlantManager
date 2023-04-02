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
    var completed = false
    var reminderDay: Date
    var taskType: PlantAction
}
//enum PlantAction: Codable {
//    case water
//    case cut
//    case fertilize
//    case repot
//}
//
//struct PlantTask: Identifiable, Codable, Hashable {
//
//    func hash(into hasher: inout Hasher) {
//        return hasher.combine(id)
//    }
//
//    static func == (lhs: PlantTask, rhs: PlantTask) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    var id = UUID().uuidString
//    var plantName: String
//    var completed = false
//    var reminderEnabled = false
//    var reminder: Reminder
//    var taskType: PlantAction
//}
//
//enum ReminderType: Int, CaseIterable, Identifiable, Codable {
//    case time
//    case calendar
//    var id: Int { self.rawValue }
//}
//
//struct Reminder: Codable {
//    var timeInterval: TimeInterval?
//    var date: Date?
//    var reminderType: ReminderType = .time
//    var repeats = false
//}

