//
//  PlantsCollectionViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit

final class PlantsCollectionViewController: UIViewController {
    
    var sample = ["Ficus", "Ficus","Ficus", "Ficus", "Ficus", "Ficus", "Ficus", "Ficus", "Ficus", "Ficus", "Ficus"]
    private let reuseIdentifier = "PlantCell"

    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    // MARK: - Lifecycle
    init() {
        plantsCollectionView = {
            let view = UICollectionView(frame: .zero, collectionViewLayout: PlantsCollectionViewController.generatePlantsCollectionViewLayout())
            return view
        }()
        super.init(nibName: nil, bundle: nil)
    }
    

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var plantsCollectionView: UICollectionView
    
    private let roomsCollectionView = UITableView(frame: .zero)
    
    private let plantsUILabel: UILabel = {
        var label = UILabel()
        label.text = "Plants"
        return label
    }()
    
    private let roomsUILabel: UILabel = {
        var label = UILabel()
        label.text = "Rooms"
        return label
    }()
    
    private let toggle: UISwitch = {
        var toggle = UISwitch()
        toggle.tintColor = .systemGreen
        return toggle
    }()
    
    private let addButton: UIButton = {
        var button = UIButton()
        var config = UIButton.Configuration.filled()
        config.titlePadding = 2.0
        config.title = "  Add +  "
        config.titleAlignment = .center
        config.baseBackgroundColor = UIColor(red: 0.18, green: 0.45, blue: 0.20, alpha: 0.55)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Plants"
        self.view.backgroundColor = UIColor(red: 18, green: 45, blue: 20, alpha: 0.5)
        
        view.addSubview(plantsUILabel)
        plantsUILabel.translatesAutoresizingMaskIntoConstraints = false
        plantsUILabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        plantsUILabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        plantsUILabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(toggle)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        toggle.leadingAnchor.constraint(equalTo: plantsUILabel.trailingAnchor, constant: 16).isActive = true
        toggle.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(roomsUILabel)
        roomsUILabel.translatesAutoresizingMaskIntoConstraints = false
        roomsUILabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        roomsUILabel.leadingAnchor.constraint(equalTo: toggle.trailingAnchor, constant: 16).isActive = true
        roomsUILabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(plantsCollectionView)
        plantsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        plantsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        plantsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        plantsCollectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16).isActive = true
        plantsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        plantsCollectionView.dataSource = self
        
        plantsCollectionView.register(PlantCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    static func generatePlantsCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 2
        )
        //3
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
          top: 4,
          leading: 4,
          bottom: 4,
          trailing: 4)
        return layout
    }
    
    @objc
    func addButtonPressed() {
        var addView: AddView
        if toggle.isOn {
            addView = AddRoomViewController()
        } else {
            addView = AddPlantViewController()
        }
        
        let nav = UINavigationController(rootViewController: addView)
        if let sheetController = nav.sheetPresentationController {
          sheetController.detents = [.medium(), .large()]
          sheetController.preferredCornerRadius = 16
          sheetController.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
}

extension PlantsCollectionViewController: UICollectionViewDelegate {

}

extension PlantsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sample.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = plantsCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlantCollectionViewCell
        cell.cellText = "Living Room"
        cell.plantNameText = sample[indexPath.row]
        cell.plantImageView = UIImage(named: "plant_img") ?? UIImage()
        return cell
    }

}

//// MARK: - Collection View Flow Layout Delegate
//extension PlantsCollectionViewController: UICollectionViewDelegateFlowLayout {
//
//  // 1
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    sizeForItemAt indexPath: IndexPath
//  ) -> CGSize {
//    // 2
//    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//    let availableWidth = view.frame.width - paddingSpace
//    let widthPerItem = availableWidth / itemsPerRow
//    return CGSize(width: widthPerItem, height: widthPerItem)
//  }
//
//  // 3
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    insetForSectionAt section: Int
//  ) -> UIEdgeInsets {
//    return sectionInsets
//  }
//
//  // 4
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    minimumLineSpacingForSectionAt section: Int
//  ) -> CGFloat {
//    return sectionInsets.left
//  }
//}
