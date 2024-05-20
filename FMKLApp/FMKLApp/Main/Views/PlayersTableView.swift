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
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dataNumber: Int) {
        super.init(frame: .zero, style: .plain)
        
        loadData(dataNumber: dataNumber)
        configure()
    }
    
    private func loadData(dataNumber: Int) {
        if dataNumber == 1 {
            fetchData1()
        } else {
            fetchData2()
        }
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
}

extension PlayersTableView {
    func fetchData1() {
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
    
    func fetchData2() {
        self.playerStats = [
            PlayerStats(points: 12, playerName: "Skotnikov A."),
            PlayerStats(points: 10, playerName: "Galcev I."),
            PlayerStats(points: 10, playerName: "Zhuravlev A."),
            PlayerStats(points: 9 , playerName: "Larin E."),
            PlayerStats(points: 8 , playerName: "Mudrov N.")
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
