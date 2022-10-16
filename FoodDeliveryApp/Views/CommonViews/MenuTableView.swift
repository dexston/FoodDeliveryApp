//
//  MainTableView.swift
//  FoodDeliveryApp
//
//  Created by Admin on 16.10.2022.
//

import UIKit

class MainTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        prepareForAutoLayout()
        sectionHeaderHeight = 68
        sectionHeaderTopPadding = .zero
        separatorInset = .zero
        backgroundColor = .secondarySystemBackground
        register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
