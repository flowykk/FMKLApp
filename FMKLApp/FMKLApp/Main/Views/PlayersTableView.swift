//
//  PlayersTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 18.05.2024.
//

import UIKit

class PlayersTableView: UITableView, UITableViewDelegate, UITableViewDataSource {        
    private var playerStats: [PlayerStats] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        fetchData()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEmpty() -> Bool {
        return playerStats.count == 0
    }
    
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        dataSource = self
        register(PlayerStatsCell.self, forCellReuseIdentifier: "PlayerStatsCell")
        rowHeight = 50
        
        separatorStyle = .none
        isScrollEnabled = false
        
        updateHeight()
    }
    
    private func updateHeight() {
        let height = rowHeight * CGFloat(playerStats.count)
        setHeight(height)
    }
}

extension PlayersTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "PlayerStatsCell") as! PlayerStatsCell
        let playerStats = playerStats[indexPath.row]
        
        cell.set(playerPlace: indexPath.row + 1, playerStats: playerStats)
        
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

extension PlayersTableView {
    func fetchData() {
        self.playerStats = [
            PlayerStats(points: 28, playerName: "Afitov A."),
            PlayerStats(points: 24, playerName: "Mudrov N."),
            PlayerStats(points: 23, playerName: "Kruglov V."),
            PlayerStats(points: 20, playerName: "Zhuravlev A."),
            PlayerStats(points: 16, playerName: "Ziden' E.")
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
