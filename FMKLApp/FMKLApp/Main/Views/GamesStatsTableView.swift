//
//  GroupTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 17.05.2024.
//

import UIKit

final class GamesStatsTableView: UITableView {
    weak var presenter: MainPresenter?
    
    var teamStats: [TeamGamesStats] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(groupNumber: Int) {
        super.init(frame: .zero, style: .plain)
        
        loadData(groupNumber: groupNumber)
        configure()
    }
    
    private func loadData(groupNumber: Int) {
        if groupNumber == 1 {
            fetchGroup1()
        } else {
            fetchGroup2()
        }
    }
    
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        dataSource = self

        register(GamesStatsCell.self, forCellReuseIdentifier: "GamesStatsCell")
        rowHeight = 50
        
        separatorStyle = .none
        isScrollEnabled = false
        
        updateHeight()
    }
    
    private func updateHeight() {
        let height = rowHeight * CGFloat(teamStats.count)
        setHeight(height)
    }
}

extension GamesStatsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "GamesStatsCell") as! GamesStatsCell
        let teamStats = teamStats[indexPath.row]
        
        cell.set(teamPlace: indexPath.row + 1, teamStats: teamStats)
        cell.presenter = presenter
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

extension GamesStatsTableView {
    func fetchGroup1() {
        self.teamStats = [
            TeamGamesStats(points: 18, teamName: "BUSUS", fullTeamName: "FC Bususiky", wins: 6, loses: 6, goalsScored: 37, goalsMissed: 19),
            TeamGamesStats(points: 15, teamName: "KUBN" , fullTeamName: "KUBAN-PESKI", wins: 6, loses: 5, goalsScored: 51, goalsMissed: 8 ),
            TeamGamesStats(points: 10, teamName: "MEMPH", fullTeamName: "MEMPHIS", wins: 6, loses: 3, goalsScored: 31, goalsMissed: 25),
            TeamGamesStats(points: 10, teamName: "CSAK" , fullTeamName: "CSAK", wins: 6, loses: 3, goalsScored: 22, goalsMissed: 29),
            TeamGamesStats(points: 6 , teamName: "MNTLT", fullTeamName: "MENTALITY", wins: 6, loses: 2, goalsScored: 26, goalsMissed: 27),
            TeamGamesStats(points: 3 , teamName: "NIKA" , fullTeamName: "NIKA", wins: 6, loses: 1, goalsScored: 33, goalsMissed: 66),
            TeamGamesStats(points: 0 , teamName: "ALGRS", fullTeamName: "ALLIGATORS", wins: 6, loses: 0, goalsScored: 23, goalsMissed: 49)
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func fetchGroup2() {
        self.teamStats = [
            TeamGamesStats(points: 17, teamName: "VSPRST", fullTeamName: "VSE PROSTO", wins: 6, loses: 6, goalsScored: 46, goalsMissed: 16),
            TeamGamesStats(points: 10, teamName: "GLDBS" , fullTeamName: "GOLDEN BOYS", wins: 6, loses: 3, goalsScored: 35, goalsMissed: 29),
            TeamGamesStats(points: 9 , teamName: "ZVZD"  , fullTeamName: "ZVEZDA", wins: 6, loses: 3, goalsScored: 25, goalsMissed: 28),
            TeamGamesStats(points: 6 , teamName: "NALAK" , fullTeamName: "NA LAKI", wins: 6, loses: 2, goalsScored: 27, goalsMissed: 30),
            TeamGamesStats(points: 5 , teamName: "CEMUN" , fullTeamName: "CEM UNITED", wins: 6, loses: 1, goalsScored: 31, goalsMissed: 26),
            TeamGamesStats(points: 5 , teamName: "KFC"   , fullTeamName: "KFC", wins: 6, loses: 2, goalsScored: 21, goalsMissed: 37)
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
