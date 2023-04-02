//
//  TaskManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift


struct TaskManager {
    
    static func loadTasks(forUser userId: String) async -> Result<[PlantTask], Error> {
        do {
            let query = DatabaseManager.shared.database
                .collection(Collections.tasks.rawValue)
                .whereField("userId", isEqualTo: userId)
                .whereField("completed", isEqualTo: false)
            let data = try await DatabaseManager.shared.getMany(of: PlantTask.self, with: query).get()
            return .success(data)
        } catch let error {
            return .failure(error)
        }
    }
    
    static func loadTasks(forPlant plantId: String) async -> Result<[PlantTask], Error> {
        do {
            let query = DatabaseManager.shared.database
                .collection(Collections.tasks.rawValue)
                .whereField("plantId", isEqualTo: plantId)
                .whereField("completed", isEqualTo: false)
            let data = try await DatabaseManager.shared.getMany(of: PlantTask.self, with: query).get()
            return .success(data)
        } catch let error {
            return .failure(error)
        }
    }
    
}
