//
//  RegistrationChangesStackView.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit

class RegistrationChangesStackView: UIStackView {
    @IBOutlet weak var registrationFormLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userPasswordLabel: UILabel!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCreditCardLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userLoginTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userCreditCardTextField: UITextField!
    @IBOutlet weak var userBioTextField: UITextField!
    
    @IBOutlet weak var registrationButton: UIButton!
    
    let model = RegistrationAndChangesViewModel()
    
    
    func configRegistrationView() {
        registrationFormLabel.text = model.registrationFormLabel
        userIdLabel.text = model.userIdLabel
        userLoginLabel.text = model.userLoginLabel
        userPasswordLabel.text = model.userPasswordLabel
        userFirstNameLabel.text = model.userFirstNameLabel
        userLastNameLabel.text = model.userLastnameLabel
        userEmailLabel.text = model.userEmailLabel
        userCreditCardLabel.text = model.userCreditCardLabel
        userBioLabel.text = model.userBioLabel
        
        registrationButton.titleLabel?.text = model.registrationButtonLabel
        
        userIdTextField.placeholder = model.userIdTextPlaceholder
        userLoginTextField.placeholder = model.userLoginTextPlaceholder
        userPasswordTextField.placeholder = model.userPasswordTextPlaceholder
        userFirstNameTextField.placeholder = model.userFirstNameTextPlaceholder
        userLastNameTextField.placeholder = model.userLastnameTextPlaceholder
        userEmailTextField.placeholder = model.userEmailTextPlaceholder
        userCreditCardTextField.placeholder = model.userCreditCardTextPlaceholder
        userBioTextField.placeholder = model.userBioTextPlaceholder
    }
    
    func configChangesView() {
        configRegistrationView()
        registrationFormLabel.text = "Update the User Data"
        registrationButton.titleLabel?.text = "Update User Data"
    }
}
