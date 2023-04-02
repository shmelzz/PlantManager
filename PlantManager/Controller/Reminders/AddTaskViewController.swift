//
//  AddTaskViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import UIKit
import FirebaseAuth

final class AddTaskViewController: UIViewController {
    
    private let taskTypes = ["Water", "Cut", "Repot", "Fertilize"]
    var plant: Plant?

    private lazy var taskTypePicker = {
        let picker = UISegmentedControl(items: taskTypes)
        picker.selectedSegmentIndex = 0
        return picker
    }()
    
    private var reminderDateTimeInput = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        return datePicker
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
        setupReminderDateTimeInput()
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
    
    private func setupReminderDateTimeInput() {
        view.addSubview(reminderDateTimeInput)
        reminderDateTimeInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reminderDateTimeInput.topAnchor.constraint(equalTo: taskTypePicker.bottomAnchor, constant: 24),
            reminderDateTimeInput.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavBar() {
        title = "Add new task"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addTask))
    }
    
    @objc
    private func cancelAdd() {
        dismiss(animated: true)
    }
    
    @objc
    private func addTask() {
        Task {
            do {
                let userId = Auth.auth().currentUser?.uid ?? ""
                let task = PlantTask(id: "",
                                     userId: userId,
                                     plantId: plant?.id ?? "",
                                     plantName: plant?.name ?? "",
                                     reminderDay: reminderDateTimeInput.date,
                                     taskType: PlantAction(rawValue: taskTypes[taskTypePicker.selectedSegmentIndex].lowercased()) ?? .water
                )
                let data = try await task.post(to: Collections.tasks.rawValue).get()
                NotificationManager.shared.scheduleNotification(task: data)
            } catch let error {
                print(error)
            }
        }
        dismiss(animated: true)
    }
}
