//
//  CardCelTableViewCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 13.06.2024.
//

import UIKit

final class CardCell: UITableViewCell {
    private let playerNameView: UIView = UIView()
    private let playerNameLabel: UILabel = UILabel()
    
    private let yellowCardsView: UIView = UIView()
    private var yellowCard: CardView = CardView()
    
    private let redCardsView: UIView = UIView()
    private var redCard: CardView = CardView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCorners()
    }
}

// MARK: - Class functions
extension CardCell {
    func set(playerCards: PlayerCards) {
        playerNameLabel.text        = playerCards.player
        redCard.set(isRed: true, count: playerCards.redCards)
        yellowCard.set(isRed: false, count: playerCards.yellowCards)
        
        playerNameLabel.textColor   = Constants.secondColor
    }
}

// MARK: - UI Configuration
extension CardCell {
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        selectionStyle = .none
        
        configureRedCardsView()
        configureRedCardView()
        
        configureYellowCardsView()
        configureYellowCardView()
                
        configurePlayerNameView()
        configurePlayerNameLabel()
    }
    
    private func configureCorners() {
        playerNameView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        yellowCardsView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        redCardsView.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
        
        separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private func configureRedCardsView() {
        redCardsView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(redCardsView)
        redCardsView.setWidth(UIScreen.main.bounds.width * 0.18)
        redCardsView.pinRight(to: self, 0)
        redCardsView.pinVertical(to: self, 2)
    }
    
    private func configureRedCardView() {
        redCardsView.addSubview(redCard)
        redCard.pinCenter(to: redCardsView)
    }
    
    private func configureYellowCardsView() {
        yellowCardsView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(yellowCardsView)
        yellowCardsView.pinRight(to: redCardsView.leadingAnchor, 4)
        yellowCardsView.setWidth(UIScreen.main.bounds.width * 0.18)
        yellowCardsView.pinVertical(to: self, 2)
    }
    
    private func configureYellowCardView() {
        yellowCardsView.addSubview(yellowCard)
        yellowCard.pinCenter(to: yellowCardsView)
    }
    
    private func configurePlayerNameView() {
        playerNameView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(playerNameView)
        playerNameView.pinLeft(to: self, 0)
        playerNameView.pinRight(to: yellowCardsView.leadingAnchor, 4)
        playerNameView.pinVertical(to: self, 2)
    }
    
    private func configurePlayerNameLabel() {
        playerNameLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        playerNameView.addSubview(playerNameLabel)
        playerNameLabel.pinLeft(to: playerNameView.leadingAnchor, 10)
        playerNameLabel.pinWidth(to: playerNameView)
        playerNameLabel.pinCenterY(to: centerYAnchor)
    }
}


