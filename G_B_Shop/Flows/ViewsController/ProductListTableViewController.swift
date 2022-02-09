//
//  ProductListTableViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 03.02.2022.
//

import UIKit
import SwiftUI
class ProductListTableViewController: UITableViewController {
    
    let cellReuseId = "ProductListTableViewCell"
    let factory = RequestFactory()
    var productList: [Product] = []
    
    //MARK: -- Private functions
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Request error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func tableTitleConfiguration() {
        self.navigationItem.title = "Product List"
        self.navigationItem.backButtonTitle = "Back"
    }
    
    private func fillTheForm() {
        let request = factory.makeProductsFactory()
        let getList = GetProductList(pageNumber: 1, categoryId: 1)
        request.productList(pageNumber: getList.pageNumber, categoryId: getList.categoryId) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                switch response.result {
                case .success(let success):
                    self.productList = success.productList
                    self.tableView.reloadData()
                case .failure(let error): self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
            }
        }
    }
    
    private func transferToProductReview() {
        let productReviewTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductAndReviewsTableViewController") as! ProductAndReviewsTableViewController
        navigationController?.pushViewController(productReviewTableViewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return productList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Product Name: \(self.productList[indexPath.section].productName)"
            cell.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            return cell
        case 1:
            cell.textLabel?.text = "Product Price: \(self.productList[indexPath.section].productPrice)"
            return cell
        case 2:
            cell.textLabel?.text = "Product Description: \(self.productList[indexPath.section].productDescription)"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.transferToProductReview()
        }
    }
    
    //MARK: -- Controller functions
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        self.tableTitleConfiguration()
        self.fillTheForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
