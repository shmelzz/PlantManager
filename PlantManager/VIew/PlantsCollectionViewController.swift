//
//  PlantsCollectionViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit


final class PlantsCollectionViewController: UIViewController {
    
    var rooms = [3, 4, 5, 6, 4, 5, 6, 4, 5, 6, 4, 5, 6, 4, 5, 6, 4, 5, 6]
    
    var plants: [Plant] = [
        Plant(name: "Lukas",
              plantType: PlantType(title: "Ficus"),
              place: Room(name: "Living Room"),
              purchaseDay: Date(),
              wateringSpan: 7
             ),
        Plant(name: "Lukas 2",
              plantType: PlantType(title: "Ficus"),
              place: Room(name: "Living Room"),
              purchaseDay: Date(),
              wateringSpan: 7
             ),
        Plant(name: "Lukas 3",
              plantType: PlantType(title: "Ficus"),
              place: Room(name: "Living Room"),
              purchaseDay: Date(),
              wateringSpan: 7
             ),
        Plant(name: "Lukas 4",
              plantType: PlantType(title: "Ficus"),
              place: Room(name: "Living Room"),
              purchaseDay: Date(),
              wateringSpan: 7
             ),
        Plant(name: "Lukas 5",
              plantType: PlantType(title: "Ficus"),
              place: Room(name: "Living Room"),
              purchaseDay: Date(),
              wateringSpan: 7
             )
    ]
    
    private let reuseIdentifier = "PlantCell"
    private let reuseIdentifierRoom = "RoomCell"

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
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        super.init(nibName: nil, bundle: nil)
    }
    
    var dateFormatter: DateFormatter

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var plantsCollectionView: UICollectionView
    
    private let roomsCollectionView = UITableView(frame: .zero, style: .insetGrouped)
    
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
        
        view.addSubview(roomsCollectionView)
        roomsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        roomsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        roomsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        roomsCollectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16).isActive = true
        roomsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        roomsCollectionView.dataSource = self
        roomsCollectionView.isHidden = true
        
        roomsCollectionView.register(RoomsTableViewCell.self, forCellReuseIdentifier: reuseIdentifierRoom)
        roomsCollectionView.dataSource = self
        roomsCollectionView.rowHeight = 80
        
        roomsCollectionView.delegate = self
        
        
        
        plantsCollectionView.register(PlantCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        plantsCollectionView.delegate = self
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        toggle.addTarget(self, action: #selector(changeViewWithToggle), for: .touchUpInside)
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
        // var addView: AddView
        // var nav = UINavigationController()
        if toggle.isOn {
            var addView = AddRoomViewController()
            
            let nav = UINavigationController(rootViewController: addView)
            if let sheetController = nav.sheetPresentationController {
              sheetController.detents = [.medium(), .large()]
              sheetController.preferredCornerRadius = 24
              sheetController.prefersGrabberVisible = true
            }
            present(nav, animated: true, completion: nil)
        } else {
            var addView = AddPlantViewController()
            
            addView.delegate = self
            
            let nav = UINavigationController(rootViewController: addView)
            if let sheetController = nav.sheetPresentationController {
              sheetController.detents = [.medium(), .large()]
              sheetController.preferredCornerRadius = 24
              sheetController.prefersGrabberVisible = true
            }
            present(nav, animated: true, completion: nil)
        }
    }
    
    @objc
    func changeViewWithToggle() {
        if toggle.isOn {
            changeFromPlantsToRooms()
        } else {
            changeFromRoomsToPlants()
        }
    }
    
    func changeFromPlantsToRooms() {
        plantsCollectionView.isUserInteractionEnabled = false
        plantsCollectionView.isHidden = true
        
        roomsCollectionView.isUserInteractionEnabled = true
        roomsCollectionView.isHidden = false
    }
    
    func changeFromRoomsToPlants() {
        plantsCollectionView.isUserInteractionEnabled = true
        plantsCollectionView.isHidden = false
        
        roomsCollectionView.isUserInteractionEnabled = false
        roomsCollectionView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plantsCollectionView.reloadData()
    }
}

extension PlantsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plantInfoView = PlantInfoView()
        plantInfoView.plant = plants[indexPath.row]
        plantInfoView.plantIndexPath = indexPath
        plantInfoView.delegate = self
        navigationController?.pushViewController(plantInfoView, animated: true)
    }
}

extension PlantsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = plantsCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlantCollectionViewCell
        cell.cellText = plants[indexPath.row].place.name
        cell.plantNameText = plants[indexPath.row].name
        cell.plantImageView = UIImage(named: "plant_img") ?? UIImage()
        return cell
    }
}

extension PlantsCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomsCollectionView.dequeueReusableCell(withIdentifier: reuseIdentifierRoom, for: indexPath) as! RoomsTableViewCell
        cell.configure(count: rooms[indexPath.row])
        return cell
    }
}

extension PlantsCollectionViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let plantInfoView = PlantInfoView()
//        navigationController?.pushViewController(plantInfoView, animated: true)
    }
}

extension PlantsCollectionViewController: AddPlantDelegate {
    func addNewPlantToCollection(newPlant: Plant) {
        plants.insert(newPlant, at: 0)
        plantsCollectionView.reloadData()
    }
}

extension PlantsCollectionViewController: PlantWasEditedDelegate {
    func plantWithIndexWasEdited(indexPath: IndexPath, newInfoPlant: Plant?) {
        plants[indexPath.row] = newInfoPlant ?? plants[indexPath.row]
        plantsCollectionView.reloadData()
    }
}
