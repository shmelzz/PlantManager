//
//  PlantNoteCollectionViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 31.03.2023.
//

import UIKit

final class PlantNoteCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PlantNoteCollectionViewCell"
    
    private lazy var noteLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        contentView.layer.cornerRadius = 16
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func setupView() {
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(note: PlantNote?) {
        noteLabel.text = note?.text
        dateLabel.text = note?.date
    }
}

