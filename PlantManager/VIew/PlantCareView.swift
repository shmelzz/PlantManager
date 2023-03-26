//
//  PlantCareView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.03.2023.
//

import UIKit

final class PlantCareView: UIView {
    
    weak var actionControllerPresenter: PlantInfoViewController?
    
    private lazy var addTaskButton = {
        let button = UIButton()
        button.setTitle("Add task to schedule", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addTaskButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var alertLabel = {
        let label = UILabel()
        label.textColor = .systemGray
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
        addSubview(alertLabel)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc
    private func addTaskButtonPressed() {
        let addTaskViewController = AddTaskViewController()
        let nav = UINavigationController(rootViewController: addTaskViewController)
        if let sheetController = nav.sheetPresentationController {
            sheetController.detents = [.medium(), .large()]
            sheetController.preferredCornerRadius = 24
            sheetController.prefersGrabberVisible = true
        }
        actionControllerPresenter?.present(nav, animated: true)
    }
}
