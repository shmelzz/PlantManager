//
//  PlantCollectionViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit

final class PlantCollectionViewCell: UICollectionViewCell {
    
    private let roomLabel = UILabel()
    private let plantNameLabel = UILabel()
    private let plantImage = UIImageView()
    

    var cellText: String {
        get {
            roomLabel.text ?? ""
        }
        set {
            roomLabel.text = newValue
        }
    }
    
    var plantNameText: String {
        get {
            plantNameLabel.text ?? ""
        }
        set {
            plantNameLabel.text = newValue
        }
    }
    
    var plantImageView: UIImage {
        get {
            plantImage.image ?? UIImage()
        }
        set {
            plantImage.image = newValue
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        roomLabel.text = nil
        plantNameLabel.text = nil
        plantImage.image = nil
    }
    
    // MARK: - Configuration
    private func configureUI() {
        contentView.layer.cornerRadius = 16
        
        contentView.addSubview(plantImage)
        contentView.addSubview(plantNameLabel)
        contentView.addSubview(roomLabel)
        
        plantImage.translatesAutoresizingMaskIntoConstraints = false
        plantImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        plantImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        plantImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        plantImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        plantImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        plantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        plantNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        plantNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        plantNameLabel.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 4).isActive = true
        plantNameLabel.numberOfLines = 0
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        roomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        roomLabel.topAnchor.constraint(equalTo: plantNameLabel.bottomAnchor, constant: 4).isActive = true
        roomLabel.numberOfLines = 0
        
        plantImage.contentMode = .scaleAspectFill
        plantImage.clipsToBounds = true
    }
}
