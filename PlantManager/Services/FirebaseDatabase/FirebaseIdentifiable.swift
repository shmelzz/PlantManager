//
//  FirebaseIdentifiable.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 02.04.2023.
//

import Foundation

protocol FirebaseIdentifiable: Hashable, Codable {
    var id: String { get set }
}

extension FirebaseIdentifiable {
    
    func post(to collection: String) async -> Result<Self, Error> {
        return await DatabaseManager.shared.post(self, to: collection)
    }
    
    func put(to collection: String) async -> Result<Self, Error> {
        return await DatabaseManager.shared.put(self, to: collection)
    }
    
    func delete(from collection: String) async -> Result<Void, Error> {
        return await DatabaseManager.shared.delete(self, in: collection)
    }
}
