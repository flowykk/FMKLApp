//
//  DevInfoBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import Foundation

final class DevInfoBuilder {
    static func build() -> DevInfoViewController {
        let viewController = DevInfoViewController()
        let router = DevInfoRouter(view: viewController)
        let presenter = DevInfoPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}

