//
//  PlantNoteCollectionViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 31.03.2023.
//

import UIKit

final class PlantNoteCollectionViewCell: UICollectionViewCell {
    
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
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func setupView() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: noteLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(note: PlantNote) {
        noteLabel.text = note.text
        dateLabel.text = note.date
    }
}

