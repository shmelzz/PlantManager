//
//  Task.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import Foundation

struct Task: Identifiable, Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    var name: String
    var completed = false
    var reminderEnabled = false
    var reminder: Reminder
}

enum ReminderType: Int, CaseIterable, Identifiable, Codable {
    case time
    case calendar
    var id: Int { self.rawValue }
}

struct Reminder: Codable {
    var timeInterval: TimeInterval?
    var date: Date?
    var reminderType: ReminderType = .time
    var repeats = false
}

