//
//  TaskManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import Foundation

class TaskManager: ObservableObject {
  static let shared = TaskManager()
  let taskPersistenceManager = TaskPersistenceManager()

  @Published var tasks: [Task] = []

  init() {
    loadTasks()
  }

  func save(task: Task) {
    tasks.append(task)
    DispatchQueue.global().async {
      self.taskPersistenceManager.save(tasks: self.tasks)
    }
    if task.reminderEnabled {
      NotificationManager.shared.scheduleNotification(task: task)
    }
  }

  func loadTasks() {
    self.tasks = taskPersistenceManager.loadTasks()
  }

    func addNewTask(_ taskName: String, _ reminder: Reminder?, taskType: PlantAction) {
    if let reminder = reminder {
      save(task: Task(plantName: taskName, reminderEnabled: true, reminder: reminder, taskType: taskType))
    } else {
      save(task: Task(plantName: taskName, reminderEnabled: false, reminder: Reminder(), taskType: taskType))
    }
  }

  func remove(task: Task) {
    tasks.removeAll {
      $0.id == task.id
    }
    DispatchQueue.global().async {
      self.taskPersistenceManager.save(tasks: self.tasks)
    }
    if task.reminderEnabled {
      NotificationManager.shared.removeScheduledNotification(task: task)
    }
  }

  func markTaskComplete(task: Task) {
    if let row = tasks.firstIndex(where: { $0.id == task.id }) {
      var updatedTask = task
      updatedTask.completed = true
      tasks[row] = updatedTask
    }
  }
}

