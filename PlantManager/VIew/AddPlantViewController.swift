//
//  AddPlantViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 12.12.2022.
//

import UIKit

final class AddPlantViewController: UIViewController, AddView {
    
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
        
        return input
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
        purchaseDateInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        purchaseDateInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        purchaseDateInput.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        purchaseDateInput.placeholder = "purchase date"
        
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy"
          purchaseDateInput.text = dateFormatter.string(from: sender.date)
     }
    
    private func setupNavBar() {
        self.title = "Add new plant"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAdd))
    }
    
    @objc
    func cancelAdd() {
        
    }
    
    @objc
    func doneAdd(){
        
    }
}
