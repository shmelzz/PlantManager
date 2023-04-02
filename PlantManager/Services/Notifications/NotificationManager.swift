//
//  NotificationManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import Foundation
import UserNotifications


class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var settings: UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
                self.fetchNotificationSettings()
                completion(granted)
            }
    }
    
    func fetchNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.settings = settings
            }
        }
    }
    
    func removeScheduledNotification(task: PlantTask) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [task.id])
    }
    
    func scheduleNotification(task: PlantTask) {
        let content = UNMutableNotificationContent()
        content.title = "Your plants are calling!"
        content.body = "Don't forget to \(task.taskType) plant"
        content.categoryIdentifier = "OrganizerPlusCategory"
        let taskData = try? JSONEncoder().encode(task)
        if let taskData = taskData {
            content.userInfo = ["Task": taskData]
        }
        
        var trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.day, .month, .year, .hour, .minute],from: task.reminderDay),
            repeats: false)
        
        let request = UNNotificationRequest(
            identifier: task.id,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
