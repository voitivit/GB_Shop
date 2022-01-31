//
//  LoginViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginStackView: LoginStackView!
    
    let requestFactory = RequestFactory()
    
    //MARK: -- Constraints settings
    private func setupConstraints() {
        self.scrollView.addSubview(loginStackView)
        self.loginStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.loginStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.loginStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.loginStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.loginStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.loginStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    //MARK: -- Controls settings
    private func setupControls() {
        self.loginStackView.loginButton.backgroundColor = UIColor.opaqueSeparator
        self.loginStackView.loginButton.isEnabled = false
        
        [self.loginStackView.loginTextField, self.loginStackView.passwordTextField].forEach {
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
            self.loginStackView.loginButton.backgroundColor = UIColor.opaqueSeparator
            self.loginStackView.loginButton.isEnabled = false
            return
        }
        
        self.loginStackView.loginButton.backgroundColor = UIColor.systemCyan
        self.loginStackView.loginButton.isEnabled = true
    }
    
    //MARK: -- Boolean func for textField filling
    func textInputed() -> Bool {
        guard self.loginStackView.loginTextField.text != "",
              self.loginStackView.passwordTextField.text != "" else {
                  return false
              }
        return true
    }
    
    //MARK: -- Clear screen
    private func clearScreen() {
        self.loginStackView.loginButton.backgroundColor = UIColor.opaqueSeparator
        self.loginStackView.loginButton.isEnabled = false
        self.loginStackView.loginTextField.text = ""
        self.loginStackView.passwordTextField.text = ""
    }
    
    // MARK: -- Transfer functions and Error Alerts
    private func transferToMainScreen() {
        
        clearScreen()
        
        let mainScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenViewController") as! MainScreenViewController
        navigationController?.pushViewController(mainScreenViewController, animated: true)
    }
    
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Authorisation error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: -- Buttons actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        if textInputed() {
            let factory = requestFactory.makeAuthRequestFactory()
            let authUser = AuthUser(userLogin: self.loginStackView.loginTextField.text!, userPassword: self.loginStackView.passwordTextField.text!)
            
            factory.login(userLogin: authUser.userLogin, userPassword: authUser.userPassword) { response in
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
            self.showError("Login or password not filled")
        }
        
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        let registrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    // MARK: -- LoginViewController functions
    override func viewWillAppear(_ animated: Bool) {
        loginStackView.configureView()
        setupConstraints()
        setupControls()
        registerNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

