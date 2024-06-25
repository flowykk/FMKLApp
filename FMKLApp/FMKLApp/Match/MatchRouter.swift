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
    
    func presentAddGoalView() {
        let vc = AddGoalBuilder.build()
        vc.modalPresentationStyle = .custom
        if let nc = view?.navigationController {
            vc.viewDistanceTop = nc.navigationBar.frame.height + 10
        }
        
        vc.matchVC = view as? MatchViewController
        view?.present(vc, animated: true)
    }
    
    func presentAddCardView() {
        let vc = AddCardBuilder.build()
        vc.modalPresentationStyle = .custom
        if let nc = view?.navigationController {
            vc.viewDistanceTop = nc.navigationBar.frame.height + 10
        }
        
        vc.matchVC = view as? MatchViewController
        view?.present(vc, animated: true)
    }
}
