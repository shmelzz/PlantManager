//
//  ImageStorageManager.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 30.03.2023.
//

import FirebaseStorage
import UIKit

final class ImageStorageManager {
    
    static let shared = ImageStorageManager()
    private let storage = Storage.storage().reference(withPath: "images")
    
    func saveImage(_ image: UIImage, path: String, completion: @escaping (Error?) -> Void ) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            self.storage.child(path).putData(data) { metadata, error in
                if error != nil { return }
                DispatchQueue.main.async { completion(nil) }
            }
        }
    }
    
    func getMainImage(path: String, completion: @escaping (UIImage?, Error?) -> Void) {
        storage.child("\(path)/main-image.jpeg").getData(maxSize: 6 * 1024 * 1024) { data, error in
            if error != nil {
                // TODO
            } else {
                DispatchQueue.main.async {
                    if let data = data {
                        let image = UIImage(data: data)
                        completion(image, nil)
                    }
                }
            }
        }
    }
    
    func getImage(path: String, completion: @escaping (UIImage?, Error?) -> Void) {
        storage.child(path).getData(maxSize: 6 * 1024 * 1024) { data, error in
            if error != nil {
                print("error detting image")
            } else {
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image, nil)
                }
            }
        }
    }
    
    func getAllImages(path: String, completion: @escaping (UIImage, Error?) -> Void) {
        storage.child(path).listAll { result, error in
            if let error = error {
                print("An error has occurred - \(error.localizedDescription)")
            } else {
                guard let result = result else { return }
                for item in result.items {
                    let name = item.name
                    self.getImage(path: "\(path)/\(name)") { image, error in
                        if error == nil,
                           let image = image{
                            completion(image, nil)
                        }
                    }
                }
            }
        }
    }
}
