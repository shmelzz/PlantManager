//
//  TaskPersistanceManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import Foundation

class TaskPersistenceManager {
    
  enum FileConstants {
    static let tasksFileName = "tasks.json"
  }

  func save(tasks: [PlantTask]) {
    do {
      let documentsDirectory = getDocumentsDirectory()
      let storageURL = documentsDirectory.appendingPathComponent(FileConstants.tasksFileName)
      let tasksData = try JSONEncoder().encode(tasks)
      do {
        try tasksData.write(to: storageURL)
      } catch {
        print("Couldn't write to File Storage")
      }
    } catch {
      print("Couldn't encode tasks data")
    }
  }

  func loadTasks() -> [PlantTask] {
    let documentsDirectory = getDocumentsDirectory()
    let storageURL = documentsDirectory.appendingPathComponent(FileConstants.tasksFileName)
    guard
      let taskData = try? Data(contentsOf: storageURL),
      let tasks = try? JSONDecoder().decode([PlantTask].self, from: taskData)
    else {
      return []
    }

    return tasks
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

