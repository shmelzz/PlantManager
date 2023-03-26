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
        label.textColor = .systemRed
        label.text = "❗️ Needs Water ❗️"
        return label
    }()
    
    private lazy var tasksTableView = UITableView(frame: .zero)
    private lazy var dataSource = DataSource(tasksTableView)
    
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
        
        addSubview(tasksTableView)
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tasksTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tasksTableView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 4),
            tasksTableView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -8)
        ])
        tasksTableView.delegate = self
        tasksTableView.separatorStyle = .none
        tasksTableView.register(RemindersTableViewCell.self, forCellReuseIdentifier: RemindersTableViewCell.remindersCellId)
        setupDataSource()
    }
    
    private func setupDataSource() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(TaskSection.allCases)
        snapshot.appendItems(tasks, toSection: .today)
        dataSource.apply(snapshot)
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

extension PlantCareView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Data source
final private class DataSource: UITableViewDiffableDataSource<TaskSection, Task> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RemindersTableViewCell.remindersCellId,
                for: indexPath
            ) as? RemindersTableViewCell
            cell?.configure(with: itemIdentifier)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case TaskSection.today.rawValue:
            return "Today"
        case TaskSection.upcoming.rawValue:
            return "Upcoming"
        default:
            return nil
        }
    }
}
