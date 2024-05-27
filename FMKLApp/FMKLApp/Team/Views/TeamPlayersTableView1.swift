//
//  TeamPlayersTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 27.05.2024.
//

import UIKit

class TeamPlayersTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
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

extension TeamPlayersTableView {
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

extension TeamPlayersTableView {
    func fetchData() {
        self.players = [
            Player(name: "Martynov D.", rank: "M", image: UIImage(named: "Basmak")),
            Player(name: "Filatov K.", rank: "P", image: UIImage(named: "Fil")),
            Player(name: "Klyuev D.", rank: "M", image: UIImage(named: "Klyu")),
            Player(name: "Kolosov P.", rank: "P", image: UIImage(named: "Kolos")),
            Player(name: "Nachinkin I.", rank: "P", image: UIImage(named: "Kraken")),
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
