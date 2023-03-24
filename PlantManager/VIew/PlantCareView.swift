//
//  PlantCareView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.03.2023.
//

import UIKit

final class PlantCareView: UIView {
    
    private lazy var addTaskButton = {
        let button = UIButton()
        button.setTitle("Add task to schedule", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addTaskButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var alertLabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var tasksTableView = UITableView(frame: .zero)
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc
    private func addTaskButtonPressed() {
//        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
    }
}
