//
//  User.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

import FirebaseFirestore
import Firebase


struct User: Codable {
    
    let uid: String
    let email: String
    var plants: [Plant] = []
    // var rooms: [RoomSpec] = []
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email ?? ""
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}

struct Plant: FirebaseIdentifiable {
    var id: String
    var userId: String
    var name: String
    var plantType: String
    var place: String
    var purchaseDay: String
    var wateringSpan: Int
}
    
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
//
//struct RoomSpec: FirebaseIdentifiable {
//    let name: String
//}

struct PlantNote: FirebaseIdentifiable {
    var id: String
    let plantId: String
    let text: String
    let date: String
}

