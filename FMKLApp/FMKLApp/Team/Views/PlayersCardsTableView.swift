//
//  PlayersCardsTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 13.06.2024.
//

import UIKit

final class PlayersCardsTableView: UITableView {
    private var playersCards: [PlayerCards] = []
    
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
extension PlayersCardsTableView {
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        register(CardCell.self, forCellReuseIdentifier: "CardCell")
        rowHeight = 50
        
        separatorStyle = .none
        isScrollEnabled = false
        
        updateHeight()
    }
    
    private func updateHeight() {
        let height = rowHeight * CGFloat(playersCards.count)
        setHeight(height)
    }
}

// MARK: - PlayersCardsTableViewDelegate + PlayersCardsTableViewDataSource
extension PlayersCardsTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "CardCell") as! CardCell
        
        let playerCards = playersCards[indexPath.row]
        
        cell.set(playerCards: playerCards)
        
        return cell
    }
}

// MARK: - Fetching Data for PlayersCardsTableView
extension PlayersCardsTableView {
    func fetchData() {
        self.playersCards = [
            PlayerCards(player: "Filatov K.", yellowCards: 0, redCards: 10),
            PlayerCards(player: "Kolosov P.", yellowCards: 2, redCards: 0),
            PlayerCards(player: "Nachinkin I.", yellowCards: 4, redCards: 1),
            PlayerCards(player: "Martynov D.", yellowCards: 1, redCards: 0),
            PlayerCards(player: "Rakhimov A.", yellowCards: 1, redCards: 1),
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
