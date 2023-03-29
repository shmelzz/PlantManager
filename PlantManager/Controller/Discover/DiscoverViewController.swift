//
//  DiscoverViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit
import FirebaseDatabase

final class DiscoverViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero)
    private lazy var dataSource = DataSource(tableView)
    private let ref = Database.database().reference(withPath: "articles")
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Discover"
        self.view.backgroundColor = .white
        fetchArticles()
        
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
        tableView.register(DiscoverArticlesTableViewCell.self, forCellReuseIdentifier: DiscoverArticlesTableViewCell.articlesCellId)
        setupDataSource()
    }
    
    private func setupDataSource() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(articles, toSection: .care)
        dataSource.apply(snapshot)
    }
    
    private func fetchArticles() {
        ref.observeSingleEvent(of: .value, with: { snapshot in
            var newItems: [Article] = []
            for child in snapshot.children {
                if
                    let snapshot = child as? DataSnapshot,
                    let groceryItem = Article(snapshot: snapshot) {
                    newItems.append(groceryItem)
                }
            }
            self.articles = newItems
        }) { error in
            print(error.localizedDescription)
        }
        print(articles)
    }
}

extension DiscoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Data source
final private class DataSource: UITableViewDiffableDataSource<Section, Article> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DiscoverArticlesTableViewCell.articlesCellId,
                for: indexPath
            ) as? DiscoverArticlesTableViewCell
            cell?.configure(with: itemIdentifier)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Plant Care"
    }
}

private enum Section: Int, CaseIterable {
    case care = 0
}

