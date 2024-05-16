//
//  SettingsRouter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class SettingsRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    func navigateToMain() {
        view?.navigationController?.popViewController(animated: true)
    }
}
