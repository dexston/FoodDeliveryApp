//
//  SaleBannerScrollView.swift
//  FoodDeliveryApp
//
//  Created by Admin on 15.10.2022.
//

import UIKit

class SaleBannerScrollView: UIView {
    
    private var totalHeight: CGFloat = 0

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
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.prepareForAutoLayout()
        scroll.addSubview(stackView)
        scroll.backgroundColor = .secondarySystemBackground
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private func setupView() {
        addSubview(scrollView)
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
            stackView.heightAnchor.constraint(equalToConstant: 112)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupBanner(with image: UIImage) -> UIImageView {
        let view = UIImageView()
        view.prepareForAutoLayout()
        view.image = image
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.heightAnchor.constraint(equalToConstant: 112).isActive = true
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        view.clipsToBounds = true
        return view
    }
    
    func update(with image: UIImage) {
        stackView.addArrangedSubview(setupBanner(with: image))
    }
}
