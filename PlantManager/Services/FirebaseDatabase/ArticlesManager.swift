//
//  ArticlesManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 02.04.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift


struct ArticlesManager {
    
    static func getAll() async -> Result<[Article], Error> {
        do {
            let query = DatabaseManager.shared.database
                .collection(Collections.articles.rawValue)
            let data = try await DatabaseManager.shared.getMany(of: Article.self, with: query).get()
            return .success(data)
        } catch let error {
            return .failure(error)
        }
    }
}

