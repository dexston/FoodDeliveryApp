//
//  FoodDataModel.swift
//  FoodDeliveryApp
//
//  Created by Admin on 13.10.2022.
//

import Foundation

struct Food: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let price: Int
    let image: URL
    let foodType: String

}
