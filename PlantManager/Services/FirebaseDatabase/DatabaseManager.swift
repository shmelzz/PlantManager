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
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init() {
        // database.isPersistenceEnabled = true
    }
    
    func postPlant(user id: String, plant: PlantSpec) {
        do {
            let data = try encoder.encode(plant)
            let json = try JSONSerialization.jsonObject(with: data)
            database.reference(withPath: "users/\(id)/plants").childByAutoId().setValue(json)
        } catch {
            print("an error occurred", error)
        }
    }
    
    func getPlants(user id: String) {
        
        //        do {
        //            let data = try encoder.encode(plant)
        //            let json = try JSONSerialization.jsonObject(with: data)
        //            database.reference(withPath: "users/\(id)/plants").childByAutoId().setValue(json)
        //        } catch {
        //            print("an error occurred", error)
        //        }
        var plants: [PlantSpec] = []
        
        database.reference(withPath: "users/\(id)/plants").getData { data, error in
            
            
        }
            //.observeSingleEvent(of: .value, with: { [weak self] snapshot in
//            for child in snapshot.children {
//                guard
//                    let self = self,
//                    var json = child. as? [String: Any]
//                else {
//                    return
//                }
//
//                json["id"] = snapshot.key
//
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: json)
//                    let thought = try self.decoder.decode(PlantSpec.self, from: data)
//                    plants.append(thought)
//                } catch {
//                    print("an error occurred", error)
//                }
//            }
//        }){ error in
//            print(error.localizedDescription)
//        }
    }
}
