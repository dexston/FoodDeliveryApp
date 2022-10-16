//
//  CategoriesScrollView.swift
//  FoodDeliveryApp
//
//  Created by Admin on 15.10.2022.
//

import UIKit

class CategoriesScrollView: UIView {
    
    private var categories: [CategoryItem]?
    private var buttons: [CategoryButton] = []
    private var totalHeight: CGFloat = 0
    private var action: (String) -> () = { text in print(text) }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(height: CGFloat) {
        let frame = CGRect(x: .zero, y: .zero, width: .zero, height: height)
        super.init(frame: frame)
        totalHeight = height
        setupView()
    }
    lazy private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.prepareForAutoLayout()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.prepareForAutoLayout()
        scroll.addSubview(stackView)
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()

    private func setupView() {
        addSubview(scrollView)
        backgroundColor = .secondarySystemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: totalHeight),
            //
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 32)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCategories() {
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupCategoryButton(with item: CategoryItem) -> CategoryButton {
        let button = CategoryButton()
        let title = item.title
        button.setTitle(title.localizedCapitalized, for: .normal)
        
        button.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.action(title)
        }, for: .touchUpInside)
        
        return button
    }
    
    func setup(with categories: [CategoryItem], currentCategory: String, action: @escaping (String) -> ()) {
        for category in categories {
            buttons.append(setupCategoryButton(with: category))
        }
        self.categories = categories
        self.action = action
        setupCategories()
        markCategoryAsSelected(with: currentCategory)
    }
    
    func update(with currentCategory: String) {
        markCategoryAsSelected(with: currentCategory)
    }
    
    private func markCategoryAsSelected(with currentCategory: String) {
        buttons.forEach { button in
            button.isSelected = button.titleLabel?.text?.lowercased() == currentCategory.lowercased()
        }
    }
}
