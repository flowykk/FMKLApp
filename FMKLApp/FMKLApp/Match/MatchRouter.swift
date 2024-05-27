//
//  MatchRouter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class MatchRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    func navigateToMain() {
        view?.navigationController?.popViewController(animated: true)
    }
}
