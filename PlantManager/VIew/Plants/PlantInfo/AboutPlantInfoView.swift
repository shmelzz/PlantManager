//
//  AboutPlantInfoView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.12.2022.
//

import UIKit

final class AboutPlantInfoView: UIStackView {
    
    private var plant: Plant?
    private lazy var typeLabel = UILabel()
    private lazy var placeLabel = UILabel()
    private lazy var purchaseLabel = UILabel()
    private lazy var wateringSpanLabel = UILabel()
    
    // MARK: - Init
    init(plant: Plant? = nil) {
        self.plant = plant
        super.init(frame: .zero)
        
        alignment = .leading
        distribution = .equalSpacing
        axis = .vertical
        spacing = 24
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlantInfo(newInfo: Plant?) {
        plant = newInfo
        configureLabels()
    }
    
    // MARK: - view setup
    private func configureLabels(){
        typeLabel.text = "Plant type: \(plant?.plantType ?? "")"
        placeLabel.text = "Place: \(plant?.place ?? "")"
        wateringSpanLabel.text = "Watering: Every \(plant?.wateringSpan ?? 0) days"
        purchaseLabel.text = "Purchase day: \(plant?.purchaseDay ?? "")"
    }
    
    private func setupView() {
        addArrangedSubview(typeLabel)
        addArrangedSubview(placeLabel)
        addArrangedSubview(purchaseLabel)
        addArrangedSubview(wateringSpanLabel)
        configureLabels()
    }
}
