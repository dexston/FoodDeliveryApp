//
//  MainTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Admin on 14.10.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var foodItem: Food? {
        didSet {
            guard let foodItem = foodItem else { return }
            titleLabel.text = foodItem.name
            descriptionLabel.text = foodItem.description
            orderButton.setTitle("\(foodItem.foodType == "pizza" ? "от " : "")\(foodItem.price) р", for: .normal)
        }
    }
    
    var foodImage: UIImage? {
        didSet {
            guard let image = foodImage else { return }
            foodImageView.image = image
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private let foodImageView: UIImageView = {
        let image = UIImageView()
        image.prepareForAutoLayout()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.prepareForAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "TitleTextColor")
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.prepareForAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "SubtitleTextColor")
        label.numberOfLines = 0
        return label
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.prepareForAutoLayout()
        button.configuration = .outlineAccentColor()
        return button
    }()
    
    private let descriptionViewContainer: UIView = {
        let stack = UIView()
        stack.prepareForAutoLayout()
        stack.clipsToBounds = true
        return stack
    }()
    
    private func setupView() {
        contentView.addSubview(foodImageView)
        descriptionViewContainer.addSubview(titleLabel)
        descriptionViewContainer.addSubview(descriptionLabel)
        descriptionViewContainer.addSubview(orderButton)
        contentView.addSubview(descriptionViewContainer)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        let constraints = [
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            foodImageView.widthAnchor.constraint(equalToConstant: 150),
            foodImageView.heightAnchor.constraint(equalToConstant: 150),
            foodImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            descriptionViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            descriptionViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            descriptionViewContainer.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 32),
            descriptionViewContainer.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: descriptionViewContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: descriptionViewContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: descriptionViewContainer.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionViewContainer.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionViewContainer.trailingAnchor),
            
            orderButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            orderButton.heightAnchor.constraint(equalToConstant: 32),
            orderButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 87),
            orderButton.trailingAnchor.constraint(equalTo: descriptionViewContainer.trailingAnchor),
            orderButton.bottomAnchor.constraint(equalTo: descriptionViewContainer.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIButton.Configuration {
    public static func outlineAccentColor() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 6
        background.strokeWidth = 1
        background.strokeColor = UIColor(named: "MainAccentColor")
        style.baseForegroundColor = UIColor(named: "MainAccentColor")
        style.background = background
        
        return style
    }
}
