//
//  RefereeCodeBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.05.2024.
//

import Foundation

final class RefereeCodeBuilder {
    static func build() -> RefereeCodeViewController {
        let viewController = RefereeCodeViewController()
        let router = RefereeCodeRouter(view: viewController)
        let presenter = RefereeCodePresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
