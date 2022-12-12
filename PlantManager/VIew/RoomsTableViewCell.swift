//
//  RoomsTableViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 12.12.2022.
//

import UIKit

final class RoomsTableViewCell: UITableViewCell {
    
    private let roomLabel = UILabel()
    private let plantsCountLabel = UILabel()
    // private let arrow = UIImageView()
    
    
    var cellText: String {
        get {
            roomLabel.text ?? ""
        }
        set {
            roomLabel.text = newValue
        }
    }
    
    var plantNameText: String {
        get {
            plantsCountLabel.text ?? ""
        }
        set {
            plantsCountLabel.text = newValue
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
    public func configure(count: Int) {
        cellText = "Living Room"
        plantNameText = "\(count) plants"
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
        
//        contentView.addSubview(arrow)
//        arrow.translatesAutoresizingMaskIntoConstraints = false
//        arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
//        arrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
//        arrow.image = UIImage(systemName: "arrow")
//        arrow.tintColor = .black
    }
}
