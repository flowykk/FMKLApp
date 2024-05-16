//
//  SettingsBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import Foundation

final class SettingsBuilder {
    static func build() -> SettingsViewController {
        let viewController = SettingsViewController()
        let router = SettingsRouter(view: viewController)
        let presenter = SettingsPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
