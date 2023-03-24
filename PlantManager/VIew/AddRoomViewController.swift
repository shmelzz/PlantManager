//
//  AddRoomViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 12.12.2022.
//

import UIKit

protocol AddRoomDelegate: AnyObject {
    func addNewRoom(newRoom: Room)
}

final class AddRoomViewController: UIViewController {
    
    weak var delegate: AddRoomDelegate?
    
    private var roomNameInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Room name"
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
        roomNameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        roomNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        roomNameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupNavBar() {
        title = "Add Room"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelAdd)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneAdd)
        )
    }
    
    @objc
    func cancelAdd() {
        dismiss(animated: true)
    }
    
    @objc
    func doneAdd(){
        let name = roomNameInput.text ?? "-"
        delegate?.addNewRoom(newRoom: Room(name: name))
        dismiss(animated: true)
    }
}

