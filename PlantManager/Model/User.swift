//
//  User.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

import FirebaseDatabase
import Firebase

struct User: Codable {
    
    let uid: String
    let email: String
    var plants: [PlantSpec] = []
    var rooms: [RoomSpec] = []
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email ?? ""
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}

struct PlantSpec: Identifiable, Codable {
    var id: String?
    var name: String
    var plantType: String
    var place: String
    var purchaseDay: Date?
    var wateringSpan: Int
    var notes: [PlantNote]?
    
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let name = value["name"] as? String,
//            let place = value["place"] as? String,
//            let plantType = value["plantType"] as? String,
//            let purchaseDay = value["purchaseDay"] as? String,
//            let wateringSpan = value["wateringSpan"] as? String
//        else {
//            return nil
//        }
//
//        self.id = snapshot.key
//        self.name = name
//        self.plantType = plantType
//        self.place = place
//        self.purchaseDay = DateUtils.dateFormatter.date(from: purchaseDay)
//        self.wateringSpan = Int(wateringSpan) ?? 7
//    }
}

struct RoomSpec: Codable {
    let name: String
}

struct PlantNote: Codable {
    let text: String
    let date: String
}

