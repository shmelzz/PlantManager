//
//  PlantPhotoCollectionViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 31.03.2023.
//

import UIKit

final class PlantPhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PlantPhotoCollectionViewCell"
    
    private lazy var photoView = {
        let view = UIImageView()
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func setupView() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.heightAnchor.constraint(equalToConstant: 100),
            photoView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 12
    }
    
    func configure(photo: UIImage) {
        photoView.image = photo
    }
}
