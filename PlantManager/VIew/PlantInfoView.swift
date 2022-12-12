//
//  PlantInfoView.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 13.12.2022.
//

import UIKit

final class PlantInfoView: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
        
        navigationItem.title = "Lukas"
        // navigationBar.tintColor = .black
    }
    
    @objc
    private func settingsTapped() {
        
    }
}
