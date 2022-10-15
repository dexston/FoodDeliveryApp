//
//  MainViewPresenter.swift
//  FoodDeliveryApp
//
//  Created by Admin on 13.10.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func scrollToRow(at row: Int)
    func updateCategories()
    func bannersFetched()
    func success()
    func failure(_ error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func fetchFoodData()
    func fetchFoodImage(for food: Food)
    func categoryButtonPressed(with foodType: String)
    func tableViewDidScroll(index: IndexPath) 
    var foodData: [Food]? { get set }
    var foodImages: [Int:UIImage] { get set }
    var bannerImages: [UIImage] { get set }
    var categories: [CategoryItem] { get set }
    var currentCategory: String { get set }
}

class MainViewPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var foodData: [Food]? {
        didSet {
            getCategories()
        }
    }
    var foodImages: [Int:UIImage]
    var bannerImages: [UIImage]
    var categories: [CategoryItem] {
        didSet {
            view?.updateCategories()
        }
    }
    var categoriesDic: [String: Int] = [:]
    var currentCategory: String = "pizza"
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        foodImages = [:]
        bannerImages = []
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
                    self.view?.success()
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
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
    
    func fetchBannerImages() {
        networkService.getBannerImages { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.bannerImages.append(result)
                self.view?.bannersFetched()
            }
        }
    }
    
    func getCategories() {
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
                view?.updateCategories()
            }
        }
    }
}
