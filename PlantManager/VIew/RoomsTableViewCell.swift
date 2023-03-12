//
//  RoomsTableViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 12.12.2022.
//

import UIKit

final class RoomsTableViewCell: UITableViewCell {
    
    private lazy var roomLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var plantsCountLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        roomLabel.text = nil
        plantsCountLabel.text = nil
    }
    
    // MARK: - Cell config
    public func configure(count: Int, roomName: String) {
        roomLabel.text = roomName
        plantsCountLabel.text = "\(count) plants"
    }
    
    // MARK: - Configuration
    private func configureUI() {        
        contentView.addSubview(roomLabel)
        contentView.addSubview(plantsCountLabel)
        plantsCountLabel.backgroundColor = .clear
        roomLabel.backgroundColor = .clear
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        roomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        roomLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        
        plantsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        plantsCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        plantsCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        plantsCountLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 8).isActive = true
    }
}
