//
//  MenuViewHeader.swift
//  FoodDeliveryApp
//
//  Created by Admin on 16.10.2022.
//

import UIKit

class MenuViewHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(height: CGFloat) {
        let frame = CGRect(x: .zero, y: .zero, width: .zero, height: height)
        super.init(frame: frame)
        setupView()
    }
    
    private var cityButton: UIButton = {
        let button = UIButton()
        button.prepareForAutoLayout()
        button.setTitle("Moscow", for: .normal)
        button.setTitleColor(UIColor(named: "TitleTextColor"), for: .normal)
        let arrowIcon = UIImage(systemName: "chevron.down")?.withTintColor(UIColor(named: "TitleTextColor")!, renderingMode: .alwaysOriginal)
        button.setImage(arrowIcon, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private func setupView() {
        prepareForAutoLayout()
        addSubview(cityButton)
        setupConstraints()
        backgroundColor = .secondarySystemBackground
    }
    
    private func setupConstraints() {
        let constraints = [
            cityButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            cityButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
