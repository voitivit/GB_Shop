//
//  MainScreenViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import UIKit
import Firebase

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainScreenStackView: MainScreenStackView!
    
    let requestFactory = RequestFactory()
    var authUser = AuthUser(userLogin: "", userPassword: "")
    
    //MARK: -- Constraints settings
    private func setupConstraints() {
        self.scrollView.addSubview(mainScreenStackView)
        self.mainScreenStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainScreenStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.mainScreenStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.mainScreenStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.mainScreenStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.mainScreenStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    //MARK: -- Prepare UserData functions
    private func loadingUserData() {
        let factory = requestFactory.makeGetRequestsFactory()
        let getUserData = GetUserData(request: "get")
        factory.getUserData(request: getUserData.request) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                switch response.result {
                case .success(let success):
                    self.authUser.userLogin = success.userLogin
                    self.authUser.userPassword = success.userPassword
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
            }
        }
    }
    
    //MARK: -- Transfers
    private func logoutTransfer() {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -- Buttons Actions
    @IBAction func changeUserDataButtonTapped(_ sender: Any) {
        let changeUserDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangeUserDataViewController") as! ChangeUserDataViewController
        navigationController?.pushViewController(changeUserDataViewController, animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let factory = requestFactory.makeAuthRequestFactory()
        factory.logout(userLogin: self.authUser.userLogin, userPassword: self.authUser.userPassword) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                switch response.result {
                case .success(let success): success.result == 1 ? self.logoutTransfer() : self.showError("Logout error")
                case .failure(let error): self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
            }
        }
        CartSingletone.shared.cartList.removeAll()
        
        Analytics.logEvent("logOut", parameters: [
            "userLogin": authUser.userLogin as NSObject
        ])
    }
    
    @IBAction func productListButtonTapped(_ sender: Any) {
        let productListTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductListTableViewController") as! ProductListTableViewController
        navigationController?.pushViewController(productListTableViewController, animated: true)
        
        Analytics.logEvent("transferToProductList", parameters: [
            "userLogin": authUser.userLogin as NSObject
        ])
    }
    
    @IBAction func cartButtonTapped(_ sender: Any) {
        let cartViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(cartViewController, animated: true)
        Analytics.logEvent("transferToCart", parameters: [
            "userLogin": authUser.userLogin as NSObject
        ])
    }
    
    //MARK: -- Controller functions
    override func viewWillAppear(_ animated: Bool) {
        mainScreenStackView.configureView()
        setupConstraints()
        loadingUserData()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
