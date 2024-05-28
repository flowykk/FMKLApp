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
    
    func presentRefereeCodeView() {
        let vc = RefereeCodeBuilder.build()
        vc.modalPresentationStyle = .custom
        if let nc = view?.navigationController {
            vc.viewDistanceTop = nc.navigationBar.frame.height + 10
        }
        
        vc.mainVC = view as? MainViewController
        view?.present(vc, animated: true)
    }
    
    func navigateToSettings() {
        let vc = SettingsBuilder.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToTeam(forFullName teamName: String, withShortName shortName: String) {
        let vc = TeamBuilder.build()
        vc.fullTeamName = teamName
        vc.shortTeamName = shortName
        
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMatchSettings() {
        if let groupsMenuVC = view?.presentedViewController {
            groupsMenuVC.dismiss(animated: true)
        }
        
        let vc = MatchBuilder.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
