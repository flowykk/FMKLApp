//
//  GroupTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 17.05.2024.
//

import UIKit

final class GamesStatsTableView: UITableView {
    var presenter: MainPresenter?
        
    private var teamStats: [TeamGamesStats] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        fetchData()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEmpty() -> Bool {
        return teamStats.count == 0
    }
    
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        dataSource = self
        register(GamesStatsCell.self, forCellReuseIdentifier: "GamesStatsCell")
        //layer.cornerRadius = 15
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
        
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("go to team")
//        //let favourite = favouriteFollowers[indexPath.row]
//        //presenter?.favouriteTapped(by: favourite)
//    }
}

extension GamesStatsTableView {
    func fetchData() {
        self.teamStats = [
            TeamGamesStats(points: 18, teamName: "BUSUS", wins: 6, loses: 6, goalsScored: 37, goalsMissed: 19),
            TeamGamesStats(points: 15, teamName: "MEMPH", wins: 6, loses: 5, goalsScored: 51, goalsMissed: 8 ),
            TeamGamesStats(points: 10, teamName: "ZVZD" , wins: 6, loses: 3, goalsScored: 31, goalsMissed: 25),
            TeamGamesStats(points: 10, teamName: "XTRM" , wins: 6, loses: 3, goalsScored: 22, goalsMissed: 29),
            TeamGamesStats(points: 6 , teamName: "FTR"  , wins: 6, loses: 2, goalsScored: 26, goalsMissed: 27),
            TeamGamesStats(points: 3 , teamName: "AVGRS", wins: 6, loses: 1, goalsScored: 33, goalsMissed: 66),
            TeamGamesStats(points: 0 , teamName: "KFC"  , wins: 6, loses: 0, goalsScored: 23, goalsMissed: 49)
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
