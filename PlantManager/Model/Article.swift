//
//  Article.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

import UIKit
import FirebaseDatabase

struct Article: Hashable {
    let title: String
    let url: URL?
    let image: URL?
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let title = value["title"] as? String,
        let url = value["url"] as? String,
        let imageUrl = value["imageUrl"] as? String
      else {
        return nil
      }

      self.title = title
      self.url = URL(string: url)
      self.image = URL(string: imageUrl)
    }
}
