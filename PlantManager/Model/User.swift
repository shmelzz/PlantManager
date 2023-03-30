//
//  User.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

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

struct PlantSpec: Codable {
    var id: String
    var name: String
    var plantType: String
    var place: String
    var purchaseDay: Date
    var wateringSpan: Int
    var notes: [PlantNote]?
    // var mainImageURL: String?
    // var images: [String]?
}

struct RoomSpec: Codable {
    let name: String
}

struct PlantNote: Codable {
    let text: String
    let date: Date
}

