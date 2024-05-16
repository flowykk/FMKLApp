//
//  MainRouter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class MainRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    func navigateToSettings() {
        let vc = SettingsBuilder.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
