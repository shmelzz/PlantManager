//
//  AddRoomViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 12.12.2022.
//

import UIKit

final class AddRoomViewController: UIViewController, AddView {
    
    private var roomNameInput: UITextField = {
        let input = UITextField()
        input.placeholder = "room name"
        input.borderStyle = .roundedRect
        return input
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavBar()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        roomNameInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        roomNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        roomNameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    private func setupNavBar() {
        self.title = "Add Room"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancelAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAdd))
    }
    
    @objc
    func cancelAdd() {
        dismiss(animated: true)
    }
    
    @objc
    func doneAdd(){
        
    }
}

protocol AddView: UIViewController {
    
}
