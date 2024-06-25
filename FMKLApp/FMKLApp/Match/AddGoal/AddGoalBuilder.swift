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
        let presenter = AddGoalPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
