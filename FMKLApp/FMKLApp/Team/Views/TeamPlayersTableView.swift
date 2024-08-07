//
//  TeamPlayersTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 27.05.2024.
//

import UIKit

final class TeamPlayersTableView: UITableView {
    weak var presenter: TeamPresenter?
    
    private var players: [Player] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        fetchData()
        configure()
    }
}

// MARK: - UI Configuration
extension TeamPlayersTableView {
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        dataSource = self
        register(PlayerCell.self, forCellReuseIdentifier: "PlayerCell")
        rowHeight = 50
        
        separatorStyle = .none
        isScrollEnabled = false
        
        updateHeight()
    }
    
    private func updateHeight() {
        let height = rowHeight * CGFloat(players.count)
        setHeight(height)
    }
}

// MARK: - TeamPlayersTableViewDelegate + TeamPlayersTableViewDataSource
extension TeamPlayersTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        let player = players[indexPath.row]
        
        cell.set(playerNumber: indexPath.row + 1, player: player)
        cell.presenter = presenter
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

// MARK: - Fetching Data for TeamPlayersTableView
extension TeamPlayersTableView {
    func fetchData() {
        self.players = [
            Player(name: "Martynov D.",  rank: "M", image: UIImage(named: "basmak"),    birth: "2005"),
            Player(name: "Filatov K.",   rank: "P", image: UIImage(named: "Fil"),       birth: "2003"),
            Player(name: "Klyuev D.",    rank: "M", image: UIImage(named: "Klyu"),      birth: "2003"),
            Player(name: "Kolosov P.",   rank: "P", image: UIImage(named: "Kolos"),     birth: "2004"),
            Player(name: "Nachinkin I.", rank: "P", image: UIImage(named: "Kraken"),     birth: "2006"),
            Player(name: "Flofer",       rank: "M", image: UIImage(named: "Flofer"),     birth: "2024"),
            Player(name: "Bashmak2",     rank: "M", image: UIImage(named: "Bashmak2"),  birth: "2055"),
            Player(name: "Zek",          rank: "P", image: UIImage(named: "Zek"),       birth: "2013"),
            Player(name: "Krasava",      rank: "M", image: UIImage(named: "Krasava"),   birth: "0001"),
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
