//
//  MainScreenStackView.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit

class MainScreenStackView: UIStackView {

    @IBOutlet weak var wellcomeLabel: UILabel!
    @IBOutlet weak var changeDataButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    let model = MainScreenModel()
    
    func configureView() {
        wellcomeLabel.text = model.wellcomeLabel
        changeDataButton.titleLabel?.text = model.changeDataButtonLabel
        logoutButton.titleLabel?.text = model.logoutButtonLabel
    }

}

