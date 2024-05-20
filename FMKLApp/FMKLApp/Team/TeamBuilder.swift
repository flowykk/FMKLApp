//
//  TeamBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.05.2024.
//

import UIKit

final class TeamBuilder {
    static func build() -> TeamViewController {
        let viewController = TeamViewController()
        let router = TeamRouter(view: viewController)
        let presenter = TeamPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
