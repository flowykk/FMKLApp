//
//  AddCardBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 25.06.2024.
//

import Foundation

final class AddCardBuilder {
    static func build() -> AddCardViewController {
        let viewController = AddCardViewController()
        let presenter = AddCardPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
