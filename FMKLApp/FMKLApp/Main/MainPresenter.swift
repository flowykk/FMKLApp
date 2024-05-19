//
//  MainPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class MainPresenter {
    private weak var view: MainViewController?
    private var router: MainRouter
    
    init(view: MainViewController?, router: MainRouter) {
        self.view = view
        self.router = router
    }
    
    func settingsButtonTapped() {
        router.navigateToSettings()
    }
    
    func viewTeamButtonTapped(for teamName: String) {
        router.navigateToTeam(for: teamName)
    }
}
