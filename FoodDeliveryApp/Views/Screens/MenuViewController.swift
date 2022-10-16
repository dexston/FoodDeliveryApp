//
//  MenuViewController.swift
//  FoodDeliveryApp
//
//  Created by Admin on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    var presenter: MenuViewPresenterProtocol?
    
    private var headerView = MenuViewHeader(height: 46)
    private var bannersView = SaleBannerScrollView(height: 136)
    private var categoriesView = CategoriesScrollView(height: 68)
    private var tableView = MainTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.backgroundColor = .secondarySystemBackground
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.tableHeaderView = bannersView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        let constraints = [
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerView.frame.height),
            //
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.foodData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        guard let presenter = presenter else { return cell }
        if let foodItem = presenter.foodData?[indexPath.row] {
            cell.foodItem = foodItem
            if let image = presenter.foodImages[foodItem.id] {
                cell.foodImage = image
            } else {
                presenter.fetchFoodImage(for: foodItem)
            }
        }
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return categoriesView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let presenter = presenter else { return }
        let contentOffset = tableView.contentOffset
        if let index = tableView.indexPathForRow(at: CGPoint(x: contentOffset.x, y: contentOffset.y + 68)) {
            presenter.tableViewDidScroll(index: index)
        }
    }
}

extension MenuViewController: MenuViewProtocol {
    
    func scrollToRow(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func setupCategories() {
        guard let presenter = presenter else { return }
        categoriesView.setup(with: presenter.categories, currentCategory: presenter.currentCategory,
                             action: { foodType in presenter.categoryButtonPressed(with: foodType) })
    }
    
    func updateCategories(with currentCategory: String) {
        categoriesView.update(with: currentCategory)
    }
    
    func updateBanners(with image: UIImage) {
        bannersView.update(with: image)
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    func failure(_ error: Error) {
        print(error)
    }
}
