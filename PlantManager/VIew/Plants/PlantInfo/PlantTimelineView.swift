//
//  PlantTimelineView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.03.2023.
//

import UIKit
import FirebaseAuth

final class PlantTimelineView: UIView {
    
    private enum Section {
        case photos
        case notes
    }
    
    weak var actionControllerPresenter: PlantInfoViewController?
    
    private var plant: Plant?
    private var notes: [PlantNote]
    private var images: [UIImage]
    var imagePicker: ImagePicker?
    
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "background")
        return collectionView
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
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
    
    init(plant: Plant?) {
        self.plant = plant
        notes = []
        images = []
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
        ])
        
        addSubview(addNoteButton)
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNoteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        addSubview(photoCollectionView)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoCollectionView.leadingAnchor.constraint(equalTo: addPhotoButton.trailingAnchor, constant: 8),
            photoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoCollectionView.topAnchor.constraint(equalTo: topAnchor),
//            photoCollectionView.bottomAnchor.constraint(equalTo: centerYAnchor),
            photoCollectionView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.5),
            addPhotoButton.centerYAnchor.constraint(equalTo: photoCollectionView.centerYAnchor),
        ])
        photoCollectionView.register(PlantPhotoCollectionViewCell.self, forCellWithReuseIdentifier: PlantPhotoCollectionViewCell.reuseId)
        
        addSubview(notesCollectionView)
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesCollectionView.leadingAnchor.constraint(equalTo: addNoteButton.trailingAnchor, constant: 8),
            notesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            notesCollectionView.topAnchor.constraint(equalTo: photoCollectionView.bottomAnchor, constant: 16),
            addNoteButton.centerYAnchor.constraint(equalTo: notesCollectionView.centerYAnchor),
        ])
        notesCollectionView.register(PlantNoteCollectionViewCell.self, forCellWithReuseIdentifier: PlantNoteCollectionViewCell.reuseId)
        
        loadNotes()
        loadImages()
    }
    
    private func loadNotes() {
        Task {
            do {
                let notes = await NotesManager.get(for: plant?.id ?? "")
                self.notes = try notes.get()
                notesCollectionView.reloadData()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func loadImages() {
        if let currentUser = Auth.auth().currentUser?.uid {
            ImageStorageManager.shared.getAllImages(path: "\(currentUser)/\(plant?.id ?? "")"){ [weak self] image, error in
                if error == nil {
                    self?.images.append(image)
                    self?.photoCollectionView.reloadData()
                }
            }
        }
    }
    
    func addImage(_ image: UIImage) {
        if let currentUser = Auth.auth().currentUser?.uid {
            ImageStorageManager.shared.saveImage(image, path: "\(currentUser)/\(plant?.id ?? "")/\(images.count+1).jpeg"){ error in
                if let error = error {
                    print(error)
                }
            }
        }
        images.append(image)
        photoCollectionView.reloadData()
    }
    
    @objc
    private func addNoteButtonPressed() {
        let alert = UIAlertController(title: "Add note", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("OK", comment: "Default action"),
            style: .default,
            handler: { [weak self] _ in
                Task {
                    do {
                        let note = PlantNote(
                            id: "",
                            plantId: self?.plant?.id ?? "",
                            text: alert.textFields?.first?.text ?? "" ,
                            date: Date().formatted()
                        )
                        self?.notes.append(note)
                        _ = try await note.post(to: Collections.notes.rawValue).get()
                        self?.notesCollectionView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
            }))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Cancel", comment: "Default action"),
            style: .default,
            handler: { _ in }))
        actionControllerPresenter?.present(alert, animated: true)
    }
    
    @objc
    private func addPhotoButtonPressed() {
        imagePicker?.present(from: actionControllerPresenter?.view ?? self)
    }
}

extension PlantTimelineView : UICollectionViewDelegate {
    
}

extension PlantTimelineView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == notesCollectionView {
            return notes.count
        } else {
            return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == notesCollectionView {
            let cell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: PlantNoteCollectionViewCell.reuseId, for: indexPath) as! PlantNoteCollectionViewCell
            cell.configure(note: notes[indexPath.row])
            return cell
        } else {
            let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PlantPhotoCollectionViewCell.reuseId, for: indexPath) as! PlantPhotoCollectionViewCell
            cell.configure(photo: images[indexPath.row])
            return cell
        }
    }
}

extension PlantTimelineView: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        addImage(image ?? UIImage())
    }
}
