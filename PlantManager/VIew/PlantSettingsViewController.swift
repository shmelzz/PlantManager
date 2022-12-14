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

final class PlantSettingsViewController: UIViewController, AddView {
    
    var plant: Plant?
    weak var delegate: EditPlantDelegate?
    weak var deleteDelegate: PlantWasDeletedSettingsDelegate?
    
    private var plantNameInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.clearButtonMode = .whileEditing
        return input
    }()
    
    private var plantTypeInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.clearButtonMode = .whileEditing
        return input
    }()
    
    private var roomNameInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        return input
    }()
    
    private var wateringSpanStepper: UIStepper = {
        let input = UIStepper()
        input.minimumValue = 1
        input.maximumValue = 50
        input.stepValue = 1
        return input
    }()
    
    private let wateringSpanLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.titleAlignment = .center
        config.title = "Delete"
        config.baseForegroundColor = .systemRed
        config.buttonSize = .medium
        button.configuration = config
        return button
    }()
    
    private var purchaseDateInput: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.maximumDate = Date()
        return datePicker
    }()
    
    private var purchaseDateLabel : UILabel = {
        let label = UILabel()
        label.text = "Purchase date:    "
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavBar()
    }
    
    private func setupCurrentSettings() {
        plantNameInput.text = plant?.name
        plantTypeInput.text = plant?.plantType.title
        roomNameInput.text = plant?.place.name
        purchaseDateInput.date = plant?.purchaseDay ?? Date()
        wateringSpanStepper.value = Double(plant?.wateringSpan ?? 0)
        wateringSpanValueChanged()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(plantNameInput)
        plantNameInput.translatesAutoresizingMaskIntoConstraints = false
        plantNameInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        plantNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        plantNameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(plantTypeInput)
        plantTypeInput.translatesAutoresizingMaskIntoConstraints = false
        plantTypeInput.topAnchor.constraint(equalTo: plantNameInput.bottomAnchor, constant: 8).isActive = true
        plantTypeInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        plantTypeInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        roomNameInput.topAnchor.constraint(equalTo: plantTypeInput.bottomAnchor, constant: 8).isActive = true
        roomNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        roomNameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        
        view.addSubview(purchaseDateInput)
        purchaseDateInput.translatesAutoresizingMaskIntoConstraints = false
        purchaseDateInput.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 8).isActive = true
        purchaseDateInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(purchaseDateLabel)
        purchaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseDateLabel.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 10).isActive = true
        purchaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        view.addSubview(wateringSpanLabel)
        wateringSpanLabel.translatesAutoresizingMaskIntoConstraints = false
        wateringSpanLabel.topAnchor.constraint(equalTo: purchaseDateInput.bottomAnchor, constant: 8).isActive = true
        wateringSpanLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        view.addSubview(wateringSpanStepper)
        wateringSpanStepper.translatesAutoresizingMaskIntoConstraints = false
        wateringSpanStepper.topAnchor.constraint(equalTo: purchaseDateInput.bottomAnchor, constant: 8).isActive = true
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
    
    @objc func wateringSpanValueChanged() {
        wateringSpanLabel.text = "Watering span:    \(Int(wateringSpanStepper.value)) days"
     }
    
    private func setupNavBar() {
        self.title = "Settings"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAdd))
    }
    
    @objc
    func deleteButtonTapped() {
        deleteDelegate?.plantWasDeleted()
        self.dismiss(animated: true)
    }
    
    @objc
    func cancelAdd() {
        self.dismiss(animated: true)
    }
    
    @objc
    func doneAdd(){
        let name = plantNameInput.text ?? "none"
        let type = plantTypeInput.text ?? "none"
        let room = Room(name: roomNameInput.text ?? "none")
        let date = purchaseDateInput.date
        let newPlant = Plant(name: name,
                             plantType: PlantType(title: type),
                             place: room,
                             purchaseDay: date,
                             wateringSpan: Int(wateringSpanStepper.value))
        self.plant = newPlant
        delegate?.plantWasEdited(editedPlant: newPlant)
        self.dismiss(animated: true)
    }
}

