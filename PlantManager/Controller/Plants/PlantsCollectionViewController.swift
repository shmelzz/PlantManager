//
//  PlantsCollectionViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit
import CoreData
import FirebaseAuth


final class PlantsCollectionViewController: UIViewController {
    
    struct RoomCount {
        let name: String
        var count: Int
    }
    
    private var rooms: [RoomCount] = []
    private var plants: [Plant] = []
    
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
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var plantsCollectionView: UICollectionView
    private lazy var roomsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var plantsUILabel: UILabel = {
        var label = UILabel()
        label.text = "Plants"
        return label
    }()
    
    private lazy var roomsUILabel: UILabel = {
        var label = UILabel()
        label.text = "Rooms"
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        var toggle = UISwitch()
        toggle.onTintColor = UIColor(red: 0.18, green: 0.45, blue: 0.20, alpha: 0.55)
        return toggle
    }()
    
    private lazy var addButton: UIButton = {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plantsCollectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Plants"
        view.backgroundColor = .white
        
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
        plantsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        plantsCollectionView.dataSource = self
        
        view.addSubview(roomsTableView)
        roomsTableView.translatesAutoresizingMaskIntoConstraints = false
        roomsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        roomsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        roomsTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16).isActive = true
        roomsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        roomsTableView.dataSource = self
        roomsTableView.isHidden = true
        roomsTableView.delegate = self
        
        roomsTableView.register(RoomsTableViewCell.self, forCellReuseIdentifier: reuseIdentifierRoom)
        roomsTableView.dataSource = self
        roomsTableView.rowHeight = 80
        
        plantsCollectionView.register(PlantCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        plantsCollectionView.delegate = self
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        toggle.addTarget(self, action: #selector(changeViewWithToggle), for: .touchUpInside)
        
        loadPlants()
        setupNavBar()
    }
    
    private func loadPlants() {
        Task {
            do {
                let books = await PlantsManager.get(for: Auth.auth().currentUser?.uid ?? "some-id")
                self.plants = try books.get()
                plantsCollectionView.reloadData()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func setupNavBar(){
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(logoutButtonPressed)
        )
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .plain,
            target: self,
            action: #selector(infoButtonPressed)
        )
    }
    
    @objc
    private func infoButtonPressed() {
        let alert = UIAlertController(title: "Greenly", message: "This is an app description", preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("OK", comment: "Default action"),
            style: .default,
            handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func logoutButtonPressed() {
        let alert = UIAlertController(title: "Sign out", message: "Do you want to sign out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Yes", comment: "Default action"),
            style: .default,
            handler: { _ in
                do {
                    try Auth.auth().signOut()
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginViewController())
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("No", comment: "Default action"),
            style: .default,
            handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    static func generatePlantsCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 2
        )
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
        if toggle.isOn {
            let addView = AddRoomViewController()
            let nav = UINavigationController(rootViewController: addView)
            if let sheetController = nav.sheetPresentationController {
                sheetController.detents = [.medium(), .large()]
                sheetController.preferredCornerRadius = 24
                sheetController.prefersGrabberVisible = true
            }
            present(nav, animated: true, completion: nil)
        } else {
            let addView = AddPlantViewController()
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
        self.getRooms()
        plantsCollectionView.isUserInteractionEnabled = false
        plantsCollectionView.isHidden = true
        
        roomsTableView.isUserInteractionEnabled = true
        roomsTableView.isHidden = false
        roomsTableView.reloadData()
    }
    
    func changeFromRoomsToPlants() {
        plantsCollectionView.isUserInteractionEnabled = true
        plantsCollectionView.isHidden = false
        
        roomsTableView.isUserInteractionEnabled = false
        roomsTableView.isHidden = true
    }
    
    private func getRooms() {
        var roomsDictionary: [String: Int] = [:]
        for plant in plants {
            if roomsDictionary.keys.contains(plant.place.lowercased().capitalized) {
                roomsDictionary[plant.place.lowercased().capitalized]!+=1
            } else {
                roomsDictionary[plant.place.lowercased().capitalized] = 1
            }
        }
        
        rooms = []
        for (key, value) in roomsDictionary {
            let roomCount = RoomCount(name: key, count: value)
            rooms.append(roomCount)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PlantsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plantInfoView = PlantInfoViewController()
        plantInfoView.plant = plants[indexPath.row]
        plantInfoView.plantIndexPath = indexPath
        plantInfoView.delegate = self
        plantInfoView.deleteDelegate = self
        navigationController?.pushViewController(plantInfoView, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PlantsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = plantsCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlantCollectionViewCell
        cell.configure(plant: plants[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDataSource
extension PlantsCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierRoom, for: indexPath) as! RoomsTableViewCell
        cell.configure(count: rooms[indexPath.row].count,roomName: rooms[indexPath.row].name)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PlantsCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - AddPlantDelegate
extension PlantsCollectionViewController: AddPlantDelegate {
    func addNewPlantToCollection(newPlant: Plant) {
        plants.insert(newPlant, at: 0)
        plantsCollectionView.reloadData()
    }
}

// MARK: - PlantWasEditedDelegate
extension PlantsCollectionViewController: PlantWasEditedDelegate {
    func plantWithIndexWasEdited(indexPath: IndexPath, newInfoPlant: Plant?) {
        plants[indexPath.row] = newInfoPlant ?? plants[indexPath.row]
        // self.editObject(index: indexPath.row, plantToEdit: newInfoPlant ?? plants[indexPath.row])
        plantsCollectionView.reloadData()
    }
}

// MARK: - PlantWasDeletedDelegate
extension PlantsCollectionViewController: PlantWasDeletedDelegate {
    func plantWithIndexWasDeleted(indexPath: IndexPath) {
        plants.remove(at: indexPath.row)
        // self.deleteObject(index: indexPath.row)
        plantsCollectionView.reloadData()
    }
}
