//
//  AboutPlantInfoView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.12.2022.
//

import UIKit

final class AboutPlantInfoView: UIStackView {
    
    private var plant: Plant?
    
    init(plant: Plant? = nil) {
        self.plant = plant
        super.init(frame: .zero)
        
        self.alignment = .leading
        self.distribution = .equalSpacing
        self.axis = .vertical
        self.spacing = 12
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
    
    private func setupView() {
        let typeLabel = UILabel()
        typeLabel.text = "Plant type: \(plant?.plantType.title ?? "")"
        typeLabel.textColor = .black
        
        let placeLabel = UILabel()
        placeLabel.text = "Place: \(plant?.place.name ?? "")"
        
        let purchaseLabel = UILabel()
        purchaseLabel.text = "Purchase day: \(plant?.purchaseDay.formatted() ?? "")"
        
        let wateringSpanLabel = UILabel()
        wateringSpanLabel.text = "Watering: Every \(plant?.wateringSpan ?? 0) days"
        
        self.addArrangedSubview(typeLabel)
        self.addArrangedSubview(placeLabel)
        self.addArrangedSubview(purchaseLabel)
        self.addArrangedSubview(wateringSpanLabel)
    }
}
