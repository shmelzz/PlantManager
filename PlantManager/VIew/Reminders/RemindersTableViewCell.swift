//
//  RemindersTableViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 26.03.2023.
//

import UIKit

final class RemindersTableViewCell: UITableViewCell {
    
    static let remindersCellId = "remindersCell"

    private lazy var taskTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private lazy var taskTypeImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var checkButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "checkmark.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal
        )
        button.setImage(UIImage(
            systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .selected
        )
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        taskTitleLabel.text = ""
        checkButton.isSelected = false
        taskTypeImageView.image = nil
    }

    // MARK: - Setup UI
    private func setupUI() {
        taskTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(taskTypeImageView)
        NSLayoutConstraint.activate([
            taskTypeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskTypeImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskTypeImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            taskTypeImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 28),
            taskTypeImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 28)
        ])
        
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(taskTitleLabel)
        NSLayoutConstraint.activate([
            taskTitleLabel.leadingAnchor.constraint(equalTo: taskTypeImageView.trailingAnchor, constant: 16),
            taskTitleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskTitleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            checkButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setTaskImage(type: PlantAction) {
        switch type {
        case .water:
            taskTypeImageView.image = UIImage(named: "action.water")
        case .cut:
            taskTypeImageView.image = UIImage(named: "action.cut")
        case .fertilize:
            taskTypeImageView.image = UIImage(named: "action.fertilize")
        case .repot:
            taskTypeImageView.image = UIImage(named: "action.repot")
        }
    }
    
    func configure(with model: PlantTask) {
        taskTitleLabel.text = "\(model.taskType.rawValue) \(model.plantName)"
        if model.completed {
            checkButton.isSelected = true
        }
        setTaskImage(type: model.taskType)
    }
}

