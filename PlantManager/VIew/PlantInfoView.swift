//
//  PlantInfoView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.12.2022.
//

import UIKit

// MARK: - Protocols
protocol PlantWasEditedDelegate: AnyObject {
    func plantWithIndexWasEdited(indexPath: IndexPath, newInfoPlant: Plant?)
}

protocol PlantWasDeletedDelegate: AnyObject {
    func plantWithIndexWasDeleted(indexPath: IndexPath)
}

protocol PlantWasDeletedSettingsDelegate: AnyObject {
    func plantWasDeleted()
}

// MARK: - Class
final class PlantInfoView: UIViewController {
    
    var plant: Plant?
    private lazy var plantImage = UIImageView()
    private lazy var aboutButton = UIButton()
    private lazy var careButton = UIButton()
    private lazy var timelineButton = UIButton()
    private lazy var aboutInfoView = AboutPlantInfoView()
    private lazy var plantCareView = PlantCareView()
    
    weak var delegate: PlantWasEditedDelegate?
    weak var deleteDelegate: PlantWasDeletedDelegate?
    var plantIndexPath: IndexPath?
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
        
        updateTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - View setup
    private func setupView() {
        var buttonConfig = Utils.configButton()
        buttonConfig.title = "About"
        aboutButton.configuration = buttonConfig
        
        buttonConfig.title = "Care"
        careButton.configuration = buttonConfig
        
        buttonConfig.title = "Timeline"
        timelineButton.configuration = buttonConfig
        
        view.addSubview(plantImage)
        plantImage.translatesAutoresizingMaskIntoConstraints = false
        plantImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        plantImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        plantImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        plantImage.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        plantImage.layer.cornerRadius = 16
        plantImage.contentMode = .scaleAspectFill
        plantImage.clipsToBounds = true
        
        view.addSubview(aboutButton)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 16).isActive = true
        aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        
        view.addSubview(timelineButton)
        timelineButton.translatesAutoresizingMaskIntoConstraints = false
        timelineButton.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 16).isActive = true
        timelineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        view.addSubview(careButton)
        careButton.translatesAutoresizingMaskIntoConstraints = false
        careButton.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 16).isActive = true
        careButton.leadingAnchor.constraint(equalTo: aboutButton.trailingAnchor, constant: 28).isActive = true
        careButton.trailingAnchor.constraint(equalTo: timelineButton.leadingAnchor, constant: -20).isActive = true
        
        view.addSubview(aboutInfoView)
        aboutInfoView.translatesAutoresizingMaskIntoConstraints = false
        aboutInfoView.topAnchor.constraint(equalTo: aboutButton.bottomAnchor, constant: 16).isActive = true
        aboutInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        aboutInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        view.addSubview(plantCareView)
        plantCareView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantCareView.topAnchor.constraint(equalTo: aboutButton.bottomAnchor, constant: 16),
            plantCareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            plantCareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plantCareView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        plantCareView.isHidden = true
        
        timelineButton.changeNotSelectedButtonView(title: "Timeline")
        careButton.changeNotSelectedButtonView(title: "Care")
        
        timelineButton.addTarget(self, action: #selector(timelineButtonTapped), for: .touchUpInside)
        careButton.addTarget(self, action: #selector(careButtonTapped), for: .touchUpInside)
        aboutButton.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
        setupAboutView()
        
        plantImage.image = plant?.image ?? UIImage(named: "plant_img")
    }
    
    private func setupAboutView() {
        aboutInfoView.plantInfo = plant ?? Plant(name: "none",
                                                 plantType: PlantType(title: "none"),
                                                 place: Room(name: "none"),
                                                 purchaseDay: Date(),
                                                 wateringSpan: 0)
    }
    
    private func updateTitle() {
        navigationItem.title = plant?.name
    }
    
    // MARK: - Actions
    @objc
    private func settingsTapped() {
        let settingsView = PlantSettingsViewController()
        settingsView.plant = self.plant
        settingsView.delegate = self
        settingsView.deleteDelegate = self
        let nav = UINavigationController(rootViewController: settingsView)
        if let sheetController = nav.sheetPresentationController {
            sheetController.detents = [.medium(), .large()]
            sheetController.preferredCornerRadius = 24
            sheetController.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
    
    @objc
    private func aboutButtonTapped() {
        aboutButton.changeSelectedButtonView(title: "About")
        careButton.changeNotSelectedButtonView(title: "Care")
        timelineButton.changeNotSelectedButtonView(title: "Timeline")
        
        aboutInfoView.isHidden = false
        plantCareView.isHidden = true
    }
    
    @objc
    private func careButtonTapped() {
        careButton.changeSelectedButtonView(title: "Care")
        aboutButton.changeNotSelectedButtonView(title: "About")
        timelineButton.changeNotSelectedButtonView(title: "Timeline")
        
        aboutInfoView.isHidden = true
        plantCareView.isHidden = false
    }
    
    @objc
    private func timelineButtonTapped() {
        timelineButton.changeSelectedButtonView(title: "Timeline")
        careButton.changeNotSelectedButtonView(title: "Care")
        aboutButton.changeNotSelectedButtonView(title: "About")
        
        aboutInfoView.isHidden = true
        plantCareView.isHidden = true
    }
}

// MARK: - EditPlantDelegate
extension PlantInfoView: EditPlantDelegate {
    func plantWasEdited(editedPlant: Plant?) {
        plant = editedPlant
        aboutInfoView.updatePlantInfo(newInfo: self.plant)
        updateTitle()
        delegate?.plantWithIndexWasEdited(indexPath: plantIndexPath ?? IndexPath(), newInfoPlant: self.plant)
    }
}

// MARK: - PlantWasDeletedDelegate
extension PlantInfoView: PlantWasDeletedDelegate {
    func plantWithIndexWasDeleted(indexPath: IndexPath) {
        deleteDelegate?.plantWithIndexWasDeleted(indexPath: indexPath)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - PlantWasDeletedSettingsDelegate
extension PlantInfoView: PlantWasDeletedSettingsDelegate {
    func plantWasDeleted() {
        plantWithIndexWasDeleted(indexPath: plantIndexPath ?? IndexPath())
    }
}

