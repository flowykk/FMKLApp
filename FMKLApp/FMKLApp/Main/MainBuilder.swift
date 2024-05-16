//
//  MainBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import Foundation

final class MainBuilder {
    static func build() -> MainViewController {
        let viewController = MainViewController()
        let router = MainRouter(view: viewController)
        let presenter = MainPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
