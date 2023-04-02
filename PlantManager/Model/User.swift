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

struct PlantNote: FirebaseIdentifiable {
    var id: String
    let plantId: String
    let text: String
    let date: String
}

