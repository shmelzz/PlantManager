//
//  AddTaskViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    private let taskTypes = ["Water", "Cut", "Repot", "Fertilize"]
    private let remindersOptions = ["Time interval", "Date"]
    private let reminderInterval = Array(1...365)
    
    private var selectedReminder: ReminderType?
    
    private lazy var taskTypePicker = {
        let picker = UISegmentedControl(items: taskTypes)
        picker.selectedSegmentIndex = 0
        return picker
    }()
    
    private lazy var reminderOptionsPicker = {
        let picker = UISegmentedControl(items: remindersOptions)
        picker.addTarget(self, action: #selector(selectedReminderChanged), for: .valueChanged)
        picker.selectedSegmentIndex = 0
        return picker
    }()
    
    private var reminderDateTimeInput = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.isHidden = true
        return datePicker
    }()
    
    private var timeIntervalInput = {
        let picker = UIPickerView(frame: .zero)
        return picker
    }()
    
    private var timeIntervalLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "Interval in days"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
    }
    
    // MARK: - View setup
    private func setupView() {
        view.backgroundColor = .white
        setupTaskTypePicker()
        setupReminderOptionsPicker()
        setupReminderDateTimeInput()
        setupIntervalLabel()
        setupTimeIntervalInput()
    }
    
    private func setupTaskTypePicker() {
        view.addSubview(taskTypePicker)
        taskTypePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskTypePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            taskTypePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskTypePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupReminderOptionsPicker() {
        view.addSubview(reminderOptionsPicker)
        reminderOptionsPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reminderOptionsPicker.topAnchor.constraint(equalTo: taskTypePicker.bottomAnchor, constant: 24),
            reminderOptionsPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            reminderOptionsPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupReminderDateTimeInput() {
        view.addSubview(reminderDateTimeInput)
        reminderDateTimeInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reminderDateTimeInput.topAnchor.constraint(equalTo: reminderOptionsPicker.bottomAnchor, constant: 24),
            reminderDateTimeInput.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupIntervalLabel() {
        view.addSubview(timeIntervalLabel)
        timeIntervalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeIntervalLabel.topAnchor.constraint(equalTo: reminderDateTimeInput.bottomAnchor, constant: 24),
            timeIntervalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupTimeIntervalInput() {
        view.addSubview(timeIntervalInput)
        timeIntervalInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeIntervalInput.topAnchor.constraint(equalTo: timeIntervalLabel.bottomAnchor, constant: 8),
            timeIntervalInput.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        timeIntervalInput.delegate = self
        timeIntervalInput.dataSource = self
    }
    
    private func setupNavBar() {
        title = "Add new task"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
    }
    
    @objc
    func cancelAdd() {
        dismiss(animated: true)
    }
    
    @objc
    func selectedReminderChanged() {
        selectedReminder = ReminderType(rawValue: reminderOptionsPicker.selectedSegmentIndex)
        timeIntervalLabel.isHidden.toggle()
        timeIntervalInput.isHidden.toggle()
        reminderDateTimeInput.isHidden.toggle()
    }
}

extension AddTaskViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        reminderInterval.count
    }
}

extension AddTaskViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(reminderInterval[row])"
    }
}

