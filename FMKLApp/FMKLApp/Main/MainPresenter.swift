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
    
    func viewTeamButtonTapped(for teamName: String) {
        router.navigateToTeam(for: teamName)
    }
    
    func loadTables() {
        self.fetchData()
    }
    
    func fetchData() {
        self.group1Table!.teamStats = [
            TeamGamesStats(points: 18, teamName: "BUSUS", wins: 6, loses: 6, goalsScored: 37, goalsMissed: 19),
            TeamGamesStats(points: 15, teamName: "MEMPH", wins: 6, loses: 5, goalsScored: 51, goalsMissed: 8 ),
            TeamGamesStats(points: 10, teamName: "ZVZD" , wins: 6, loses: 3, goalsScored: 31, goalsMissed: 25),
            TeamGamesStats(points: 10, teamName: "XTRM" , wins: 6, loses: 3, goalsScored: 22, goalsMissed: 29),
            TeamGamesStats(points: 6 , teamName: "FTR"  , wins: 6, loses: 2, goalsScored: 26, goalsMissed: 27),
            TeamGamesStats(points: 3 , teamName: "AVGRS", wins: 6, loses: 1, goalsScored: 33, goalsMissed: 66),
            TeamGamesStats(points: 0 , teamName: "KFC"  , wins: 6, loses: 0, goalsScored: 23, goalsMissed: 49)
        ]
    
        self.group1Table!.reloadData()
    }
}
