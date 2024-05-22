//
//  MainPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class MainPresenter {
    private weak var view: MainViewController?
    weak var group1Table: GamesStatsTableView?
    weak var group2Table: GamesStatsTableView?
    private var router: MainRouter
    
    init(view: MainViewController?, router: MainRouter) {
        self.view = view
        self.router = router
    }
    
    func settingsButtonTapped() {
        router.navigateToSettings()
    }
    
    func goRefereeButtonTapped() {
        router.presentRefereeCodeView()
    }
    
    func viewTeamButtonTapped(forFullName teamName: String, withShortName shortName: String) {
        router.navigateToTeam(forFullName: teamName, withShortName: shortName)
    }
}
