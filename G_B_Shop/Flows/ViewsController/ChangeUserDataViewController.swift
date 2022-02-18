//
//  ChangeUserDataViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit
import Firebase

class ChangeUserDataViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var changeDataStackView: RegistrationChangesStackView!
    
    let requestFactory = RequestFactory()
    
    //MARK: -- Constraints settings
    private func setupConstraints() {
        self.scrollView.addSubview(changeDataStackView)
        self.changeDataStackView.translatesAutoresizingMaskIntoConstraints = false
        self.changeDataStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.changeDataStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.changeDataStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.changeDataStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.changeDataStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    //MARK: -- Controls settings
    private func setupControls() {
        self.changeDataStackView.registrationButton.backgroundColor = UIColor.opaqueSeparator
        self.changeDataStackView.registrationButton.isEnabled = false
        
        [self.changeDataStackView.userIdTextField,
         self.changeDataStackView.userLoginTextField,
         self.changeDataStackView.userPasswordTextField,
         self.changeDataStackView.userFirstNameTextField,
         self.changeDataStackView.userLastNameTextField,
         self.changeDataStackView.userEmailTextField,
         self.changeDataStackView.userCreditCardTextField,
         self.changeDataStackView.userBioTextField
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
        guard let userInfo = notification.userInfo else {
            let userInfo = [
                NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
                NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
                NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Does this page exist?", comment: ""),
                "ProductID": "G_B_Shop",
                "View": "ChangeUserDataView"
            ]
            let error = NSError.init(domain: NSCocoaErrorDomain,
                                     code: -1001,
                                     userInfo: userInfo)
            Crashlytics.crashlytics().record(error: error)
            return
        }
        
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
            self.changeDataStackView.registrationButton.backgroundColor = UIColor.opaqueSeparator
            self.changeDataStackView.registrationButton.isEnabled = false
            return
        }
        
        self.changeDataStackView.registrationButton.backgroundColor = UIColor.systemCyan
        self.changeDataStackView.registrationButton.isEnabled = true
    }
    
    //MARK: -- Boolean func for textField filling
    func textInputed() -> Bool {
        guard
            self.changeDataStackView.userIdTextField.text != "",
            self.changeDataStackView.userLoginTextField.text != "",
            self.changeDataStackView.userPasswordTextField.text != "",
            self.changeDataStackView.userFirstNameTextField.text != "",
            self.changeDataStackView.userLastNameTextField.text != "",
            self.changeDataStackView.userEmailTextField.text != "",
            self.changeDataStackView.userCreditCardTextField.text != "",
            self.changeDataStackView.userBioTextField.text != ""
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
        self.changeDataStackView.userIdTextField.text = ""
        self.changeDataStackView.userLoginTextField.text = ""
        self.changeDataStackView.userPasswordTextField.text = ""
        self.changeDataStackView.userFirstNameTextField.text = ""
        self.changeDataStackView.userLastNameTextField.text = ""
        self.changeDataStackView.userEmailTextField.text = ""
        self.changeDataStackView.userCreditCardTextField.text = ""
        self.changeDataStackView.userBioTextField.text = ""
        
        self.changeDataStackView.registrationButton.backgroundColor = UIColor.opaqueSeparator
        self.changeDataStackView.registrationButton.isEnabled = false
    }
    
    //MARK: -- Fill the form after loading
    private func firstFillForm() {
        let factory = requestFactory.makeGetRequestsFactory()
        let getUserData = GetUserData(request: "get")
        
        factory.getUserData(request: getUserData.request) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                
                switch response.result {
                case .success(let success):
                    self.changeDataStackView.userIdTextField.text = String(success.userId)
                    self.changeDataStackView.userLoginTextField.text = success.userLogin
                    self.changeDataStackView.userPasswordTextField.text = success.userPassword
                    self.changeDataStackView.userFirstNameTextField.text = success.userName
                    self.changeDataStackView.userLastNameTextField.text = success.userLastname
                    self.changeDataStackView.userEmailTextField.text = success.userEmail
                    self.changeDataStackView.userCreditCardTextField.text = success.userCreditCard
                    self.changeDataStackView.userBioTextField.text = success.userBio
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
            }
        }
    }
    
    //MARK: -- Transfer
    @IBAction func changeUserDataButtonTapped() {
        if textInputed() {
            let factory = requestFactory.makeRegistrationAndDataChangesFactory()
            let registrationUser = RegistrationAndChangesUser(
                userId: Int(self.changeDataStackView.userIdTextField.text!)!,
                userLogin: self.changeDataStackView.userLoginTextField.text!,
                userPassword: self.changeDataStackView.userPasswordTextField.text!,
                userName: self.changeDataStackView.userFirstNameTextField.text!,
                userLastname: self.changeDataStackView.userLastNameTextField.text!,
                userEmail: self.changeDataStackView.userEmailTextField.text!,
                userCreditCard: self.changeDataStackView.userCreditCardTextField.text!,
                userBio: self.changeDataStackView.userBioTextField.text!)
            
            factory.dataChange(userId: registrationUser.userId, userLogin: registrationUser.userLogin, userPassword: registrationUser.userPassword, userName: registrationUser.userName, userLastname: registrationUser.userLastname, userEmail: registrationUser.userEmail, userCreditCard: registrationUser.userCreditCard, userBio: registrationUser.userBio) { response in
                DispatchQueue.main.async {
                    logging(Logger.funcStart)
                    logging(response)
                    
                    switch response.result {
                    case .success(let success): success.result == 1 ? self.transferToMainScreen() : self.showError("Request error")
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
        changeDataStackView.configChangesView()
        setupConstraints()
        setupControls()
        registerNotifications()
        firstFillForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
