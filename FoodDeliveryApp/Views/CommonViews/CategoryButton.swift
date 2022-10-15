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
            strokeColor = UIColor(named: "SecondaryAccentColor")!
            foregroundColor = UIColor(named: "SecondaryAccentColor")!
            backgroundColor = .clear
        case .highlighted:
            strokeColor = UIColor(named: "MainAccentColor")!
            foregroundColor = UIColor(named: "MainAccentColor")!
            backgroundColor = UIColor(named: "SecondaryAccentColor")!
        case .selected:
            strokeColor = .clear
            foregroundColor = UIColor(named: "MainAccentColor")!
            backgroundColor = UIColor(named: "SecondaryAccentColor")!
        case [.selected, .highlighted]:
            strokeColor = UIColor(named: "MainAccentColor")!
            foregroundColor = UIColor(named: "MainAccentColor")!
            backgroundColor = UIColor(named: "SecondaryAccentColor")!
        default:
            strokeColor = UIColor(named: "SecondaryAccentColor")!
            foregroundColor = UIColor(named: "SecondaryAccentColor")!
            backgroundColor = .clear
        }
        
        background.strokeColor = strokeColor
        background.backgroundColor = backgroundColor
        
        updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.background = background
        
        self.configuration = updatedConfiguration
    }
}

//extension UIButton.Configuration {
//    public static func selectedCategoryButton() -> UIButton.Configuration {
//        var style = UIButton.Configuration.plain()
//        var background = UIButton.Configuration.plain().background
//        background.cornerRadius = 20
//        background.backgroundColor = UIColor(named: "SecondaryAccentColor")
//        style.background = background
//
//        return style
//    }
//    public static func outlineAccentColor() -> UIButton.Configuration {
//        var style = UIButton.Configuration.plain()
//        var background = UIButton.Configuration.plain().background
//        background.cornerRadius = 20
//        background.strokeWidth = 1
//        background.strokeColor = UIColor(named: "SecondaryAccentColor")
//        style.background = background
//
//        return style
//    }
//}


//button.setTitle(title, for: .normal)
//button.configuration = .plain()
//button.configuration?.background.cornerRadius = 20
//button.configuration?.baseForegroundColor = UIColor(named: "SecondaryAccentColor")
//button.heightAnchor.constraint(equalToConstant: 32).isActive = true
//button.widthAnchor.constraint(equalToConstant: 88).isActive = true
//button.clipsToBounds = true
