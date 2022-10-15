//
//  NetworkService.swift
//  FoodDeliveryApp
//
//  Created by Admin on 14.10.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getFoodData(complition: @escaping (Result<[Food]?, Error>) -> Void)
    func getFoodImage(url: URL, complition: @escaping (Result<UIImage?, Error>) -> Void)
    func getBannerImages(complition: @escaping (UIImage) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let bannerURLs = [
        URL(string: "https://ruhqphdevback01.pizzahut.ru/storage/46499/conversions/yjaqzfgJPK1finztDvM3zonyAjQTE29YPfH5vwsl-optimize.jpg")!,
        URL(string: "https://ruhqphdevback01.pizzahut.ru/storage/51308/conversions/NaQQ4MRhrffFjRy79pde4YS9JJ58JfIkML0wvPxt-optimize.jpg")!,
        URL(string: "https://ruhqphdevback01.pizzahut.ru/storage/15213/conversions/ljNS0CMrJcb9hlsGiD1ZJRCmcYwdSSzX0fLqvaad-optimize.jpg")!
    ]
    
    func getFoodData(complition: @escaping (Result<[Food]?, Error>) -> Void) {
        
        let urlString = "https://run.mocky.io/v3/44d99074-251c-48ea-be9d-4878554bab85"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Food].self, from: data)
                    complition(.success(result))
                }
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    func getFoodImage(url: URL, complition: @escaping (Result<UIImage?, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            if let data = data {
                let result = UIImage(data: data)
                complition(.success(result))
            }
        }.resume()
    }
    
    func getBannerImages(complition: @escaping (UIImage) -> Void) {
        for url in bannerURLs {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil else { return }
                if let data = data,
                   let image = UIImage(data: data){
                    complition(image)
                }
            }.resume()
        }
    }
}
