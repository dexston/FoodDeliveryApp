//
//  MainViewController.swift
//  FoodDeliveryApp
//
//  Created by Admin on 13.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol?
    
    private var headerView = UIView()
    private var categoriesView: CategoriesScrollView?
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupTableView()
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupHeaderView() {
        headerView.prepareForAutoLayout()
        headerView.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        tableView.prepareForAutoLayout()
        tableView.sectionHeaderHeight = 68
        tableView.sectionHeaderTopPadding = .zero
        tableView.separatorInset = .zero
        tableView.register(FoodItemTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        let constraints = [
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 46),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.foodData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodItemTableViewCell
        if let foodItem = presenter?.foodData?[indexPath.row] {
            cell.foodItem = foodItem
            if let image = presenter?.foodImages[foodItem.id] {
                cell.foodImage = image
            } else {
                presenter?.fetchFoodImage(for: foodItem)
            }
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let presenter = presenter else { return UIView() }
        if categoriesView == nil {
            categoriesView = CategoriesScrollView(height: 68) { foodType in
                presenter.categoryButtonPressed(with: foodType)
            }
        }
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

extension MainViewController: MainViewProtocol {
    func scrollToRow(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func updateCategories() {
        guard let presenter = presenter else { return }
        if categoriesView?.categories == nil {
            categoriesView?.setup(with: presenter.categories, currentCategory: presenter.currentCategory)
        } else {
            categoriesView?.update(with: presenter.currentCategory)
        }
    }
    
    func bannersFetched() {
        guard let presenter = presenter else { return }
        tableView.tableHeaderView = SaleBannerScrollView(height: 136, images: presenter.bannerImages)
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(_ error: Error) {
        print(error)
    }
}
