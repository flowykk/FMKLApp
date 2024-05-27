//
//  MatchBuilder.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import Foundation

final class MatchBuilder {
    static func build() -> MatchViewController {
        let viewController = MatchViewController()
        let router = MatchRouter(view: viewController)
        let presenter = MatchPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
