//
//  PlantSettingsViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 14.12.2022.
//

import UIKit

protocol EditPlantDelegate: AnyObject {
    func plantWasEdited(editedPlant: Plant?)
}

final class PlantSettingsViewController: UIViewController {
    
    var plant: Plant?
    weak var delegate: EditPlantDelegate?
    weak var deleteDelegate: PlantWasDeletedSettingsDelegate?
    
    private lazy var plantNameInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.clearButtonMode = .whileEditing
        return input
    }()
    
    private lazy var plantTypeInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.clearButtonMode = .whileEditing
        return input
    }()
    
    private lazy var roomNameInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        return input
    }()
    
    private lazy var wateringSpanStepper: UIStepper = {
        let input = UIStepper()
        input.minimumValue = 1
        input.maximumValue = 50
        input.stepValue = 1
        return input
    }()
    
    private lazy var wateringSpanLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.titleAlignment = .center
        config.title = "Delete"
        config.baseForegroundColor = .systemRed
        config.buttonSize = .medium
        button.configuration = config
        return button
    }()
    
    private lazy var purchaseDateInput: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.maximumDate = Date()
        return datePicker
    }()
    
    private lazy var purchaseDateLabel : UILabel = {
        let label = UILabel()
        label.text = "Purchase date:    "
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavBar()
    }
    
    // MARK: - setup view
    private func setupCurrentSettings() {
        plantNameInput.text = plant?.name
        plantTypeInput.text = plant?.plantType
        roomNameInput.text = plant?.place
        purchaseDateInput.date = DateFormatter().date(from: plant?.purchaseDay ?? "") ?? Date()
        wateringSpanStepper.value = Double(plant?.wateringSpan ?? 0)
        wateringSpanValueChanged()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(plantNameInput)
        plantNameInput.translatesAutoresizingMaskIntoConstraints = false
        plantNameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        plantNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        plantNameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(plantTypeInput)
        plantTypeInput.translatesAutoresizingMaskIntoConstraints = false
        plantTypeInput.topAnchor.constraint(equalTo: plantNameInput.bottomAnchor, constant: 16).isActive = true
        plantTypeInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        plantTypeInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        roomNameInput.topAnchor.constraint(equalTo: plantTypeInput.bottomAnchor, constant: 16).isActive = true
        roomNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        roomNameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        
        view.addSubview(purchaseDateInput)
        purchaseDateInput.translatesAutoresizingMaskIntoConstraints = false
        purchaseDateInput.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 16).isActive = true
        purchaseDateInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(purchaseDateLabel)
        purchaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseDateLabel.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 16).isActive = true
        purchaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        view.addSubview(wateringSpanLabel)
        wateringSpanLabel.translatesAutoresizingMaskIntoConstraints = false
        wateringSpanLabel.topAnchor.constraint(equalTo: purchaseDateInput.bottomAnchor, constant: 16).isActive = true
        wateringSpanLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        view.addSubview(wateringSpanStepper)
        wateringSpanStepper.translatesAutoresizingMaskIntoConstraints = false
        wateringSpanStepper.topAnchor.constraint(equalTo: purchaseDateInput.bottomAnchor, constant: 16).isActive = true
        wateringSpanStepper.leadingAnchor.constraint(equalTo: wateringSpanLabel.trailingAnchor, constant: 12).isActive = true
        wateringSpanStepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36).isActive = true
        
        wateringSpanStepper.addTarget(self, action: #selector(wateringSpanValueChanged), for: .valueChanged)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        setupCurrentSettings()
    }
    
    private func setupNavBar() {
        title = "Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEdit))
    }
    
    // MARK: - Actions
    @objc func wateringSpanValueChanged() {
        wateringSpanLabel.text = "Watering span:    \(Int(wateringSpanStepper.value)) days"
     }
    
    @objc
    func deleteButtonTapped() {
        Task {
            do {
                _ = try await plant?.delete(from: Collections.plants.rawValue).get()
            } catch let error {
                print(error)
            }
        }
        deleteDelegate?.plantWasDeleted()
        self.dismiss(animated: true)
    }
    
    @objc
    func cancelAdd() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func doneEdit(){
        plant?.name = plantNameInput.text ?? "none"
        plant?.plantType = plantTypeInput.text ?? "none"
        plant?.place = roomNameInput.text ?? "none"
        plant?.wateringSpan = Int(wateringSpanStepper.value)
        // plant?.purchaseDay = purchaseDateInput.date.formatted()
        
        Task {
            do {
                _ = try await plant?.put(to: Collections.plants.rawValue).get()
            } catch let error {
                print(error)
            }
        }
        
        delegate?.plantWasEdited(editedPlant: plant)
        self.dismiss(animated: true)
    }
}

