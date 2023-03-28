//
//  RemindersViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit

enum TaskSection: Int, Hashable, CaseIterable {
    case today = 0
    case upcoming
}

final class RemindersViewController: UIViewController {
    
    var taskManager = TaskManager.shared
    private lazy var tableView = UITableView(frame: .zero)
    private lazy var dataSource = DataSource(tableView)
    
    private enum Constants {
        static let sectionHeight: CGFloat = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reminders"
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.register(RemindersTableViewCell.self, forCellReuseIdentifier: RemindersTableViewCell.remindersCellId)
        setupDataSource()
    }
    
    private func setupDataSource() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(TaskSection.allCases)
        snapshot.appendItems(tasks, toSection: .today)
        dataSource.apply(snapshot)
    }
    
}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tasks[indexPath.row].completed {
            tasks[indexPath.row].completed = false
        } else {
            tasks[indexPath.row].completed = true
        }
        setupDataSource()
        tableView.reloadData()
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

var tasks = [
    Task(plantName: "somethimg", reminder: Reminder(), taskType: .water),
    Task(plantName: "somethong2", reminder: Reminder(), taskType: .cut),
    Task(plantName: "somethimg3", reminder: Reminder(), taskType: .fertilize),
    Task(plantName: "somethimg4", reminder: Reminder(), taskType: .repot),
]

