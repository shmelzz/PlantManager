//
//  AddTaskViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import UIKit

final class AddTaskViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
    }
    
    // MARK: - View setup
    private func setupView() {
        view.backgroundColor = .white
        
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
}

