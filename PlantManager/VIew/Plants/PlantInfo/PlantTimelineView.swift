//
//  PlantTimelineView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.03.2023.
//

import UIKit

final class PlantTimelineView: UIView{
    
    private enum Section {
        case photos
        case notes
    }
    
    weak var actionControllerPresenter: PlantInfoViewController?
    
    private var plant: Plant?
    private var notes: [PlantNote]?
    private var images: [UIImage]?
    
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "background")
        return collectionView
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "background")
        return collectionView
    }()
    
    private lazy var addNoteButton = {
        let button = UIButton()
        button.setTitle("Add note", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var addPhotoButton = {
        let button = UIButton()
        button.setTitle("Add photo", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init(plant: Plant? = nil) {
        self.plant = plant
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(addPhotoButton)
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addPhotoButton.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        addSubview(addNoteButton)
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNoteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addNoteButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 24)
        ])
        
        addSubview(photoCollectionView)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoCollectionView.leadingAnchor.constraint(equalTo: addPhotoButton.trailingAnchor, constant: 8),
            photoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoCollectionView.topAnchor.constraint(equalTo: topAnchor),
            photoCollectionView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.5)
        ])
        
        addSubview(notesCollectionView)
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesCollectionView.leadingAnchor.constraint(equalTo: addNoteButton.trailingAnchor, constant: 8),
            notesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notesCollectionView.topAnchor.constraint(equalTo: photoCollectionView.bottomAnchor, constant: 8),
            notesCollectionView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    @objc
    private func addNoteButtonPressed() {
        let alert = UIAlertController(title: "Add note", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("OK", comment: "Default action"),
            style: .default,
            handler: { _ in }))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Cancel", comment: "Default action"),
            style: .default,
            handler: { _ in }))
        actionControllerPresenter?.present(alert, animated: true)
    }
    
    @objc
    private func addPhotoButtonPressed() {
        
    }
}

extension PlantTimelineView : UICollectionViewDelegate {
    
}

extension PlantTimelineView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == notesCollectionView {
            return notes?.count ?? 0
        } else {
            return images?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == notesCollectionView {
            let cell = PlantNoteCollectionViewCell()
            cell.configure(note: notes?[indexPath.row])
            return cell
        } else {
            let cell = PlantPhotoCollectionViewCell()
            cell.configure(photo: images?[indexPath.row] ?? UIImage())
            return cell
        }
    }
}
