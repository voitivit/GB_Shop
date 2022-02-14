//
//  CartViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.02.2022.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payCartButton: UIButton!
    
    let factory = RequestFactory()
    let cellId = "CartCell"
    var user = RegistrationAndChangesUser(userId: 0, userLogin: "No", userPassword: "No", userName: "No", userLastname: "No", userEmail: "No", userCreditCard: "No", userBio: "No")
    
    // MARK: -- Private functions
    
    private func firstConfiguration() {
        self.navigationItem.title = "Cart"
        if CartSingletone.shared.cartList.count > 0 {
            payCartButton.isHidden = false
        } else {
            payCartButton.isHidden = true
        }
    }
    
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Request error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.transferToRegistrationForm()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showApprovedAlert() {
        let alert = UIAlertController(title: "Успешная оплата", message: "Спасибо за покупку!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.transferToMainScreen()
            CartSingletone.shared.cartList.removeAll()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func transferToMainScreen() {
        let mainScreenController = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenViewController") as! MainScreenViewController
        navigationController?.pushViewController(mainScreenController, animated: true)
    }
    
    private func transferToRegistrationForm() {
        let changeUserDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangeUserDataViewController") as! ChangeUserDataViewController
        navigationController?.pushViewController(changeUserDataViewController, animated: true)
    }
    
    private func getPaymentData() {
        let factory = factory.makeGetRequestsFactory()
        let getUserData = GetUserData(request: "get")
        
        factory.getUserData(request: getUserData.request) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                switch response.result {
                case .success(let success):
                    self.user = success
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
            }
        }
    }
    
    //MARK: -- ViewController lifeCicle functions
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        getPaymentData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstConfiguration()
    }
    
    //MARK: -- TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CartSingletone.shared.cartList.count > 0 {
            return CartSingletone.shared.cartList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        if CartSingletone.shared.cartList.count > 0 {
            cell.textLabel?.text = CartSingletone.shared.cartList[indexPath.row].productName
            return cell
        } else {
            cell.textLabel?.text = "There is no any items!"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CartSingletone.shared.cartList.remove(at: indexPath.row)
        self.tableView.reloadData()
        if CartSingletone.shared.cartList.count == 0 {
            payCartButton.isHidden = true
        }
        return
    }
    
    // MARK: -- Buttons actions
    
    @IBAction func payCartButtonTapped(_ sender: Any) {
        if user.userCreditCard == "No" {
            showError("There is no credit card data. Please fill the registration form.")
        } else {
            showApprovedAlert()
        }
    }
}

