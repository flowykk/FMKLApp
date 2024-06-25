//
//  AddGoalBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 25.06.2024.
//

import Foundation

final class AddGoalBuilder {
    static func build() -> AddGoalViewController {
        let viewController = AddGoalViewController()
        let router = AddGoalRouter(view: viewController)
        let presenter = AddGoalPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
