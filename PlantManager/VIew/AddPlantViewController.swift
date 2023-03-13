//
//  AddPlantViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 12.12.2022.
//

import UIKit

protocol AddPlantDelegate: AnyObject {
    func addNewPlantToCollection(newPlant: Plant)
}

final class AddPlantViewController: UIViewController, AddView {
    
    weak var delegate: AddPlantDelegate?
    
    var imagePicker: ImagePicker?
    
    private var plantNameInput: UITextField = {
        let input = UITextField()
        input.placeholder = "plant name"
        input.borderStyle = .roundedRect
        input.clearButtonMode = .whileEditing
        return input
    }()
    
    private var plantTypeInput: UITextField = {
        let input = UITextField()
        input.placeholder = "plant type"
        input.borderStyle = .roundedRect
        input.clearButtonMode = .whileEditing
        return input
    }()
    
    private var roomNameInput: UITextField = {
        let input = UITextField()
        input.placeholder = "room name"
        input.borderStyle = .roundedRect
        return input
    }()
    
    private var wateringSpanStepper: UIStepper = {
        let input = UIStepper()
        input.minimumValue = 1
        input.maximumValue = 50
        input.stepValue = 1
        input.value = 5
        return input
    }()
    
    private let wateringSpanLabel: UILabel = {
        let label = UILabel()
        label.text = "Watering span:    5 days"
        return label
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
    
    private let addPhotoButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.titleAlignment = .center
        config.title = "Add photo"
        config.buttonSize = .medium
        button.configuration = config
        return button
    }()
    
    private let plantImage = UIImageView()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    // MARK: - View setup
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
        
        view.addSubview(addPhotoButton)
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48).isActive = true
        
        view.addSubview(plantImage)
        plantImage.translatesAutoresizingMaskIntoConstraints = false
        plantImage.topAnchor.constraint(equalTo: wateringSpanStepper.topAnchor, constant: 48).isActive = true
        plantImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        plantImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        plantImage.bottomAnchor.constraint(equalTo: addPhotoButton.topAnchor, constant: -24).isActive = true
        plantImage.layer.cornerRadius = 16
        plantImage.contentMode = .scaleAspectFill
        plantImage.clipsToBounds = true
        
        wateringSpanStepper.addTarget(self, action: #selector(wateringSpanValueChanged), for: .valueChanged)
        addPhotoButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
    }
    
    private func setupNavBar() {
        title = "Add new plant"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAdd))
    }
    
    // MARK: - Actions
    @objc
    private func wateringSpanValueChanged() {
        wateringSpanLabel.text = "Watering span:    \(Int(wateringSpanStepper.value)) days"
    }
    
    @objc
    private func showImagePicker() {
        imagePicker?.present(from: self.view)
    }
    
    @objc
    func cancelAdd() {
        dismiss(animated: true)
    }
    
    @objc
    func doneAdd(){
        let name = plantNameInput.text ?? "none"
        let type = plantTypeInput.text ?? "none"
        let room = Room(name: roomNameInput.text ?? "none")
        let date = purchaseDateInput.date
        let newPlant = Plant(name: name,
                             plantType: PlantType(title: type),
                             place: room, purchaseDay: date,
                             wateringSpan: Int(wateringSpanStepper.value),
                             image: plantImage.image)
        delegate?.addNewPlantToCollection(newPlant: newPlant)
        self.dismiss(animated: true)
    }
}

// MARK: - ImagePickerDelegate
extension AddPlantViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        plantImage.image = image
    }
}
