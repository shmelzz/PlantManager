//
//  PlantCollectionViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit

final class PlantCollectionViewCell: UICollectionViewCell {
    
    private let roomLabel = UILabel()
    
    private lazy var plantNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let plantImage = UIImageView()
    

    var roomNameText: String {
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
        contentView.addSubview(plantImage)
        contentView.addSubview(plantNameLabel)
        contentView.addSubview(roomLabel)
        
        plantImage.translatesAutoresizingMaskIntoConstraints = false
        plantImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        plantImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        plantImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        plantImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75).isActive = true
        
        plantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        plantNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        plantNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        plantNameLabel.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 4).isActive = true
        plantNameLabel.numberOfLines = 0
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            roomLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            roomLabel.topAnchor.constraint(equalTo: plantNameLabel.bottomAnchor, constant: 4),
        ])
        
        plantImage.contentMode = .scaleAspectFill
        plantImage.clipsToBounds = true
        plantImage.layer.cornerRadius = 12      
    }
}
