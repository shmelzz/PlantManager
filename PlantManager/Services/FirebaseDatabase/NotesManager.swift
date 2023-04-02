//
//  NotesManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 02.04.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift


struct NotesManager {
    
    static func get(for plantId: String) async -> Result<[PlantNote], Error> {
        do {
            let query = DatabaseManager.shared.database
                .collection(Collections.notes.rawValue)
                .whereField("plantId", isEqualTo: plantId)
            let data = try await DatabaseManager.shared.getMany(of: PlantNote.self, with: query).get()
            return .success(data)
        } catch let error {
            return .failure(error)
        }
    }
}
