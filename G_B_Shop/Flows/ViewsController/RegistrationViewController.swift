//
//  RegistrationViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registrationStackView: RegistrationChangesStackView!
    
    let requestFactory = RequestFactory()
    
    //MARK: -- Constraints settings
    private func setupConstraints() {
        self.scrollView.addSubview(registrationStackView)
        self.registrationStackView.translatesAutoresizingMaskIntoConstraints = false
        self.registrationStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.registrationStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.registrationStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.registrationStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.registrationStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    //MARK: -- Controls settings
    private func setupControls() {
        self.registrationStackView.registrationButton.backgroundColor = UIColor.opaqueSeparator
        self.registrationStackView.registrationButton.isEnabled = false
        
        [self.registrationStackView.userIdTextField,
         self.registrationStackView.userLoginTextField,
         self.registrationStackView.userPasswordTextField,
         self.registrationStackView.userFirstNameTextField,
         self.registrationStackView.userLastNameTextField,
         self.registrationStackView.userEmailTextField,
         self.registrationStackView.userCreditCardTextField,
         self.registrationStackView.userBioTextField
        ].forEach {
            $0.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
        }
    }
    
    //MARK: -- Notifications settings
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: -- Selectors
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        contentInset.bottom = keyboardFrame.size.height + 200
        self.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard self.textInputed() else {
            self.registrationStackView.registrationButton.backgroundColor = UIColor.opaqueSeparator
            self.registrationStackView.registrationButton.isEnabled = false
            return
        }
        
        self.registrationStackView.registrationButton.backgroundColor = UIColor.systemCyan
        self.registrationStackView.registrationButton.isEnabled = true
    }
    
    //MARK: -- Boolean func for textField filling
    func textInputed() -> Bool {
        guard
            self.registrationStackView.userIdTextField.text != "",
            self.registrationStackView.userLoginTextField.text != "",
            self.registrationStackView.userPasswordTextField.text != "",
            self.registrationStackView.userFirstNameTextField.text != "",
            self.registrationStackView.userLastNameTextField.text != "",
            self.registrationStackView.userEmailTextField.text != "",
            self.registrationStackView.userCreditCardTextField.text != "",
            self.registrationStackView.userBioTextField.text != ""
        else {
            return false
        }
        return true
    }
    
    //MARK: -- Transfer functions
    private func transferToMainScreen() {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenViewController") as! MainScreenViewController
        navigationController?.pushViewController(mainViewController, animated: true)
        
        clearScreen()
    }
    
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Registration error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -- Clear screen
    private func clearScreen() {
        self.registrationStackView.userIdTextField.text = ""
        self.registrationStackView.userLoginTextField.text = ""
        self.registrationStackView.userPasswordTextField.text = ""
        self.registrationStackView.userFirstNameTextField.text = ""
        self.registrationStackView.userLastNameTextField.text = ""
        self.registrationStackView.userEmailTextField.text = ""
        self.registrationStackView.userCreditCardTextField.text = ""
        self.registrationStackView.userBioTextField.text = ""
        
        self.registrationStackView.registrationButton.backgroundColor = UIColor.opaqueSeparator
        self.registrationStackView.registrationButton.isEnabled = false
    }
    
    //MARK: -- Buttons Actions
    @IBAction func registrationButtonTapped(_ sender: Any) {
        if textInputed() {
            let factory = requestFactory.makeRegistrationAndDataChangesFactory()
            let registrationUser = RegistrationAndChangesUser(
                userId: Int(self.registrationStackView.userIdTextField.text!)!,
                userLogin: self.registrationStackView.userLoginTextField.text!,
                userPassword: self.registrationStackView.userPasswordTextField.text!,
                userName: self.registrationStackView.userFirstNameTextField.text!,
                userLastname: self.registrationStackView.userLastNameTextField.text!,
                userEmail: self.registrationStackView.userEmailTextField.text!,
                userCreditCard: self.registrationStackView.userCreditCardTextField.text!,
                userBio: self.registrationStackView.userBioTextField.text!)
            
            factory.registration(userId: registrationUser.userId, userLogin: registrationUser.userLogin, userPassword: registrationUser.userPassword, userName: registrationUser.userName, userLastname: registrationUser.userLastname, userEmail: registrationUser.userEmail, userCreditCard: registrationUser.userCreditCard, userBio: registrationUser.userBio) { response in
                DispatchQueue.main.async {
                    logging(Logger.funcStart)
                    logging(response)
                    
                    switch response.result {
                    case .success(let success): success.result == 1 ? self.transferToMainScreen() : self.showError("Authorisation error")
                    case .failure(let error): self.showError(error.localizedDescription)
                    }
                    logging(Logger.funcEnd)
                }
            }
        } else {
            self.showError("Please fill all form")
        }
    }
    
    //MARK: -- ViewController functions
    override func viewWillAppear(_ animated: Bool) {
        setupConstraints()
        registrationStackView.configRegistrationView()
        setupControls()
        registerNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
