//
//  ProductAndReviewsTableViewController.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 09.02.2022.
//
//Продукт/Отзывы
import UIKit

class ProductAndReviewsTableViewController: UITableViewController {
    
    
    let factory = RequestFactory()
    let cellId = "ProductReviewCell"
    
    var product = Product(productPrice: 0, productName: "", productDescription: "")
    var reviewsList: [ProductReview] = []
    
    //MARK: -- Private functions
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Request error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func tableTitleConfiguration() {
        self.navigationItem.title = product.productName
    }
    
    private func fillTheForm() {
        let productRequest = factory.makeProductsFactory()
        let reviewsRequest = factory.makeProductsReviewsFactory()
        let productId = 123
        
        productRequest.product(productId: productId) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                switch response.result {
                case .success(let success):
                    self.product.productName = success.productName
                    self.product.productPrice = success.productPrice
                    self.product.productDescription = success.productDescription
                case .failure(let error): self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
                self.tableTitleConfiguration()
            }
        }
        
        reviewsRequest.productReviewsList(productId: productId) { response in
            DispatchQueue.main.async {
                logging(Logger.funcStart)
                logging(response)
                switch response.result {
                case .success(let success):
                    self.reviewsList = success.productReviews
                case .failure(let error): self.showError(error.localizedDescription)
                }
                logging(Logger.funcEnd)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.reviewsList.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Review ID: \(self.reviewsList[indexPath.section].reviewId)"
            cell.textLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            return cell
        case 1:
            cell.textLabel?.text = "From: \(self.reviewsList[indexPath.section].userName)"
            return cell
        case 2:
            cell.textLabel?.text = "Rating of product: \(self.reviewsList[indexPath.section].productRating)"
            return cell
        case 3:
            cell.textLabel?.text = "Review: \(self.reviewsList[indexPath.section].userReview)"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: -- Controller functions
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        fillTheForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
