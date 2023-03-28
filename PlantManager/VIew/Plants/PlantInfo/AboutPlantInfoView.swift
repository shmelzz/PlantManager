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
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var plantInfo: Plant {
        get {
            plant ?? Plant(name: "none",
                           plantType: PlantType(title: "none"),
                           place: Room(name: "none"),
                           purchaseDay: Date(),
                           wateringSpan: 0)
        }
        set {
            plant = newValue
            setupView()
        }
    }
    
    func updatePlantInfo(newInfo: Plant?) {
        plant = newInfo
        configureLabels()
    }
    
    // MARK: - view setup
    private func configureLabels(){
        typeLabel.text = "Plant type: \(plant?.plantType.title ?? "")"
        placeLabel.text = "Place: \(plant?.place.name ?? "")"
        wateringSpanLabel.text = "Watering: Every \(plant?.wateringSpan ?? 0) days"
        purchaseLabel.text = "Purchase day: \(plant?.purchaseDay.formatted(date: .long, time: .omitted) ?? "")"
    }
    
    private func setupView() {
        configureLabels()
        addArrangedSubview(typeLabel)
        addArrangedSubview(placeLabel)
        addArrangedSubview(purchaseLabel)
        addArrangedSubview(wateringSpanLabel)
    }
}
