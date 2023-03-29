//
//  DiscoverArticlesTableViewCell.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 29.03.2023.
//

import UIKit

final class DiscoverArticlesTableViewCell: UITableViewCell {
    
    static let articlesCellId = "articleCell"

    private lazy var titleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()

    private lazy var articleImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        return view
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
        titleLabel.text = ""
        articleImageView.image = nil
    }

    // MARK: - Setup UI
    private func setupUI() {
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            articleImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 150)
        ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    func configure(with model: Article) {
        titleLabel.text = model.title
        articleImageView.image = UIImage(named: "launchphoto")
    }
}


