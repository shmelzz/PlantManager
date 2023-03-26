//
//  NotificationManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import Foundation
import UserNotifications

enum NotificationManagerConstants {
  static let timeBasedNotificationThreadId =
    "TimeBasedNotificationThreadId"
  static let calendarBasedNotificationThreadId =
    "CalendarBasedNotificationThreadId"
}

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

  func removeScheduledNotification(task: Task) {
    UNUserNotificationCenter.current()
      .removePendingNotificationRequests(withIdentifiers: [task.id])
  }

  func scheduleNotification(task: Task) {
    let content = UNMutableNotificationContent()
    content.title = task.name
    content.body = "Gentle reminder for your task!"
    content.categoryIdentifier = "OrganizerPlusCategory"
    let taskData = try? JSONEncoder().encode(task)
    if let taskData = taskData {
      content.userInfo = ["Task": taskData]
    }

    var trigger: UNNotificationTrigger?
      switch task.reminder.reminderType {
      case .time:
          if let timeInterval = task.reminder.timeInterval {
              trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: timeInterval,
                repeats: task.reminder.repeats)
          }
          content.threadIdentifier =
          NotificationManagerConstants.timeBasedNotificationThreadId
      case .calendar:
          if let date = task.reminder.date {
              trigger = UNCalendarNotificationTrigger(
                dateMatching: Calendar.current.dateComponents(
                    [.day, .month, .year, .hour, .minute],
                    from: date),
                repeats: task.reminder.repeats)
          }
          content.threadIdentifier =
          NotificationManagerConstants.calendarBasedNotificationThreadId
      }

    if let trigger = trigger {
      let request = UNNotificationRequest(
        identifier: task.id,
        content: content,
        trigger: trigger)
        
      UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
          print(error)
        }
      }
    }
  }
}
