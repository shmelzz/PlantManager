//
//  DatabaseManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 30.03.2023.
//

import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database()
    
    init() {
        database.isPersistenceEnabled = true
    }
    
    
}
