//
//  Article.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

import UIKit

struct Article: FirebaseIdentifiable {
    var id: String
    let title: String
    let url: String
    let image: String
}
