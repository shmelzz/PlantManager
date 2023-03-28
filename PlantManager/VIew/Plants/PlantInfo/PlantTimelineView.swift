//
//  PlantTimelineView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.03.2023.
//

import UIKit

final class PlantTimelineView: UICollectionView {
    
    private enum Section {
        case photos
        case notes
    }
    
    private var plant: Plant?
    
    init(plant: Plant? = nil) {
        self.plant = plant
        super.init(frame: .zero, collectionViewLayout: PlantTimelineView.generatePlantsCollectionViewLayout())
    }
    
    static func generatePlantsCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 1
        )
        //3
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4)
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
