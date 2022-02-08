//
//  LoginStackView.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit
class LoginStackView: UIStackView {
    @IBOutlet weak var shopLogo: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    var model = LoginViewModel()
   
    //MARK: -- View Configuration function
    func configureView() {
        shopLogo.image = model.shopLogo
        loginLabel.text = model.loginLabel
        passwordLabel.text = model.passwordLabel
        descriptionLabel.text = model.descriptionAppLabel
        loginButton.titleLabel?.text = model.loginButtonLabel
        registrationButton.titleLabel?.text = model.registrationButtonLabel
        loginTextField.placeholder = model.loginTextFieldPlaceholder
        passwordTextField.placeholder = model.passwordTextFieldPlaceholder
    }
}
