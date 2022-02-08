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
    @IBOutlet weak var productListButton: UIButton!
    
    let model = MainScreenModel()
    
    //MARK: -- Configuration function
    func configureView() {
        wellcomeLabel.text = model.wellcomeLabel
        changeDataButton.titleLabel?.text = model.changeDataButtonLabel
        logoutButton.titleLabel?.text = model.logoutButtonLabel
        productListButton.titleLabel?.text = model.productsListButtonLabel
    }
    
}


