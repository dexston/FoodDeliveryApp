//
//  MenuViewPresenter.swift
//  FoodDeliveryApp
//
//  Created by Admin on 13.10.2022.
//

import Foundation
import UIKit

protocol MenuViewProtocol: AnyObject {
    func scrollToRow(at row: Int)
    func setupCategories()
    func updateCategories(with currentCategory: String)
    func updateBanners(with image: UIImage)
    func updateTable()
    func failure(_ error: Error)
}

protocol MenuViewPresenterProtocol: AnyObject {
    init(view: MenuViewProtocol, networkService: NetworkServiceProtocol)
    func fetchFoodData()
    func fetchFoodImage(for food: Food)
    func categoryButtonPressed(with foodType: String)
    func tableViewDidScroll(index: IndexPath) 
    var foodData: [Food]? { get set }
    var foodImages: [Int:UIImage] { get set }
    var categories: [CategoryItem] { get set }
    var currentCategory: String { get set }
}

class MenuViewPresenter: MenuViewPresenterProtocol {
    
    weak var view: MenuViewProtocol?
    let networkService: NetworkServiceProtocol
    
    var foodImages: [Int:UIImage]
    var foodData: [Food]? {
        didSet {
            getCategories()
        }
    }
    
    private var categoriesDic: [String: Int] = [:]
    var currentCategory: String = "pizza" {
        didSet {
            view?.updateCategories(with: currentCategory)
        }
    }
    var categories: [CategoryItem] {
        didSet {
            view?.setupCategories()
        }
    }
    
    required init(view: MenuViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        foodImages = [:]
        categories = []
        fetchFoodData()
        fetchBannerImages()
    }
    
    func fetchFoodData() {
        networkService.getFoodData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.foodData = data
                    self.view?.updateTable()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
    
    func fetchFoodImage(for food: Food) {
        networkService.getFoodImage(url: food.image) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.foodImages[food.id] = data
                    self.view?.updateTable()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
    
    private func fetchBannerImages() {
        networkService.getBannerImages { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.updateBanners(with: result)
            }
        }
    }
    
    private func getCategories() {
        guard let foodData = foodData else { return }
        var categoriesDic: [String: Int] = [:]
        var categoriesArray: [CategoryItem] = []
        for i in foodData.indices {
            let type = foodData[i].foodType
            if categoriesDic[type] == nil {
                categoriesDic[type] = i
                categoriesArray.append(CategoryItem(title: type))
            }
        }
        categories = categoriesArray
        self.categoriesDic = categoriesDic
    }
    
    func categoryButtonPressed(with foodType: String) {
        if let row = categoriesDic[foodType] {
            view?.scrollToRow(at: row)
        }
    }
    
    func tableViewDidScroll(index: IndexPath) {
        if let foodType = foodData?[index.row].foodType {
            if foodType != currentCategory {
                currentCategory = foodType
            }
        }
    }
}
