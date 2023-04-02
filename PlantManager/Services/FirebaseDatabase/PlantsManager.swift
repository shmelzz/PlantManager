//
//  PlantsManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 02.04.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

enum Collections: String {
    case users = "users"
    case plants = "plants"
    case articles = "articles"
    case tasks = "tasks"
    case notes = "notes"
}

struct PlantsManager {
    
//    static func get(by id: String) async -> Result<PlantSpec, Error> {
//        do {
//            let query = DatabaseManager.shared.database
//                .collection(Collections.users.rawValue)
//                .whereField("id", isEqualTo: id)
//
//            let data = try await DatabaseManager.shared.getOne(of: PlantSpec.self, with: query).get()
//            return .success(data)
//        } catch let error {
//            return .failure(error)
//        }
//    }
    
    static func get(for userId: String) async -> Result<[Plant], Error> {
        do {
            let query = DatabaseManager.shared.database
                .collection(Collections.plants.rawValue)
                .whereField("userId", isEqualTo: userId)
            let data = try await DatabaseManager.shared.getMany(of: Plant.self, with: query).get()
            return .success(data)
        } catch let error {
            return .failure(error)
        }
    }
}
