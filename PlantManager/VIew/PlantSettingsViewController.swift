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
    
    private lazy var datePicker: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()
    
    private var purchaseDateInput = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavBar()
    }
    
    private func setupCurrentSettings() {
        plantNameInput.text = plant?.name
        plantTypeInput.text = plant?.plantType.title
        roomNameInput.text = plant?.place.name
        purchaseDateInput.text = plant?.purchaseDay.formatted()
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
        purchaseDateInput.borderStyle = .roundedRect
        purchaseDateInput.translatesAutoresizingMaskIntoConstraints = false
        purchaseDateInput.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 8).isActive = true
        purchaseDateInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        purchaseDateInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(wateringSpanLabel)
        wateringSpanLabel.translatesAutoresizingMaskIntoConstraints = false
        wateringSpanLabel.topAnchor.constraint(equalTo: purchaseDateInput.bottomAnchor, constant: 8).isActive = true
        wateringSpanLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        view.addSubview(wateringSpanStepper)
        wateringSpanStepper.translatesAutoresizingMaskIntoConstraints = false
        wateringSpanStepper.topAnchor.constraint(equalTo: purchaseDateInput.bottomAnchor, constant: 8).isActive = true
        wateringSpanStepper.leadingAnchor.constraint(equalTo: wateringSpanLabel.trailingAnchor, constant: 12).isActive = true
        wateringSpanStepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        // purchaseDateInput.inputView = datePicker
        // datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        purchaseDateInput.placeholder = "purchase date"
        wateringSpanStepper.addTarget(self, action: #selector(wateringSpanValueChanged), for: .valueChanged)
        
        setupCurrentSettings()
    }
    
    @objc func wateringSpanValueChanged() {
        wateringSpanLabel.text = "Watering span:    \(Int(wateringSpanStepper.value)) days"
     }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
          purchaseDateInput.text = DateUtils.dateFormatter.string(from: sender.date)
     }
    
    private func setupNavBar() {
        self.title = "Settings"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAdd))
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
        let date = purchaseDateInput.text ?? "none"
        let newPlant = Plant(name: name, plantType: PlantType(title: type), place: room, purchaseDay: Date(),
                             wateringSpan: Int(wateringSpanStepper.value))
        self.plant = newPlant
        delegate?.plantWasEdited(editedPlant: newPlant)
        self.dismiss(animated: true)
    }
}

