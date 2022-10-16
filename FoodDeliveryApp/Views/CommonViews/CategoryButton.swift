//
//  CategoryButton.swift
//  FoodDeliveryApp
//
//  Created by Admin on 15.10.2022.
//

import UIKit

class CategoryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        prepareForAutoLayout()
        configuration = .plain()
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: 88).isActive = true
    }
}

extension CategoryButton {
    override func updateConfiguration() {
        guard let configuration = configuration else { return }
        
        var updatedConfiguration = configuration
        var background = UIButton.Configuration.plain().background
        
        background.cornerRadius = 20
        
        let strokeColor: UIColor
        let foregroundColor: UIColor
        let backgroundColor: UIColor
        
        switch self.state {
        case .normal:
            strokeColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.4)
            foregroundColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.4)
            backgroundColor = .clear
        case .highlighted:
            strokeColor = UIColor(named: "MainAccentColor")!
            foregroundColor = UIColor(named: "MainAccentColor")!
            backgroundColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.4)
        case .selected:
            strokeColor = .clear
            foregroundColor = UIColor(named: "MainAccentColor")!
            backgroundColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.2)
        case [.selected, .highlighted]:
            strokeColor = UIColor(named: "MainAccentColor")!
            foregroundColor = UIColor(named: "MainAccentColor")!
            backgroundColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.4)
        default:
            strokeColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.4)
            foregroundColor = UIColor(named: "MainAccentColor")!.withAlphaComponent(0.4)
            backgroundColor = .clear
        }
        
        background.strokeColor = strokeColor
        background.backgroundColor = backgroundColor
        
        updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.background = background
        
        self.configuration = updatedConfiguration
    }
}
