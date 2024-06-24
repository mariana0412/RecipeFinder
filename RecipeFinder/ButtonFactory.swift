//
//  ButtonFactory.swift
//  RecipeFinder
//
//  Created by Mariana Piz on 12.06.2024.
//

import UIKit

class ButtonFactory {
    static func makeButton(withTitle title: String, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = " " + title
        configuration.baseForegroundColor = UIColor(named: "BackgroundColor")
        configuration.baseBackgroundColor = UIColor(named: "LabelColor")
        configuration.cornerStyle = .medium
        configuration.image = UIImage(systemName: imageName)
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        configuration.attributedTitle = AttributedString(" " + title, attributes: container)
        
        button.configuration = configuration
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }
}
