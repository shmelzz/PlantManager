//
//  AboutPlantInfoView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.12.2022.
//

import UIKit

final class AboutPlantInfoView: UIStackView {
    
    private var plant: Plant?
    private let typeLabel = UILabel()
    private let placeLabel = UILabel()
    private let purchaseLabel = UILabel()
    private let wateringSpanLabel = UILabel()
    
    init(plant: Plant? = nil) {
        self.plant = plant
        super.init(frame: .zero)
        
        self.alignment = .leading
        self.distribution = .equalSpacing
        self.axis = .vertical
        self.spacing = 18
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var plantInfo: Plant {
        get {
            plant ?? Plant(name: "none", plantType: PlantType(title: "none"), place: Room(name: "none"), purchaseDay: Date(),
                           wateringSpan: 0)
        }
        set {
            plant = newValue
            setupView()
        }
    }
    
    func updatePlantInfo(newInfo: Plant?) {
        self.plant = newInfo
        configureLabels()
    }
    
    private func configureLabels(){
        typeLabel.text = "Plant type: \(plant?.plantType.title ?? "")"
        placeLabel.text = "Place: \(plant?.place.name ?? "")"
        purchaseLabel.text = "Purchase day: \(plant?.purchaseDay.formatted() ?? "")"
        wateringSpanLabel.text = "Watering: Every \(plant?.wateringSpan ?? 0) days"
    }
    
    private func setupView() {
        configureLabels()
        
        self.addArrangedSubview(typeLabel)
        self.addArrangedSubview(placeLabel)
        self.addArrangedSubview(purchaseLabel)
        self.addArrangedSubview(wateringSpanLabel)
    }
}
