//
//  RemindersViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit
import FirebaseAuth

enum TaskSection: Int, Hashable, CaseIterable {
    case today = 0
    case upcoming
}

final class RemindersViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero)
    private lazy var dataSource = DataSource(tableView)
    private var tasks: [PlantTask] = []
    private var todayTasks: [PlantTask] = []
    private var upcomingTasks: [PlantTask] = []
    
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
        loadTasks()
    }
    
    private func setupDataSource() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(TaskSection.allCases)
        todayTasks = tasks.filter{ Calendar.current.isDateInToday($0.reminderDay)}
        upcomingTasks = tasks.filter{ !Calendar.current.isDateInToday($0.reminderDay)}
        snapshot.appendItems(todayTasks, toSection: .today)
        snapshot.appendItems(upcomingTasks, toSection: .upcoming)
        dataSource.apply(snapshot)
    }
    
    private func updateDataSource() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(TaskSection.allCases)
        snapshot.appendItems(todayTasks, toSection: .today)
        snapshot.appendItems(upcomingTasks, toSection: .upcoming)
        dataSource.apply(snapshot)
    }
    
    private func loadTasks() {
        Task {
            do {
                if let userId = Auth.auth().currentUser?.uid {
                    let tasks = await TaskManager.loadTasks(forUser:  userId)
                    self.tasks = try tasks.get()
                    setupDataSource()
                }
            } catch let error {
                print(error)
            }
        }
    }
}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            todayTasks[indexPath.row].completed.toggle()
            Task {
                await self.todayTasks[indexPath.row].put(to: Collections.tasks.rawValue)
            }
        } else {
            upcomingTasks[indexPath.row].completed.toggle()
            Task {
                await self.upcomingTasks[indexPath.row].put(to: Collections.tasks.rawValue)
            }
        }
        updateDataSource()
        tableView.reloadData()
    }
}

// MARK: - Data source
final private class DataSource: UITableViewDiffableDataSource<TaskSection, PlantTask> {
    
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

