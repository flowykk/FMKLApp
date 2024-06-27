//
//  PlayersTableViewCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 18.05.2024.
//

import UIKit

final class PlayerStatsCell: UITableViewCell {
    private let playerPlaceLabel: UILabel = UILabel()
    
    private let pointsView: UIView = UIView()
    private let pointsLabel: UILabel = UILabel()
    
    private let playerNameView: UIView = UIView()
    private let playerNameLabel: UILabel = UILabel()
    
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
extension PlayerStatsCell {
    func set(playerPlace: Int, playerStats: PlayerStats) {
        playerPlaceLabel.text     = String(playerPlace)
        pointsLabel.text        = String(playerStats.points)
        playerNameLabel.text      = playerStats.playerName
        
        playerPlaceLabel.textColor    = Constants.secondColor
        pointsLabel.textColor       = Constants.secondColor
        playerNameLabel.textColor     = Constants.secondColor
        
        if playerPlace == 1 {
            pointsView.backgroundColor  = Constants.firstPlaceColor
        } else if playerPlace == 2 {
            pointsView.backgroundColor  = Constants.secondPlaceColor
        } else if playerPlace == 3 {
            pointsView.backgroundColor  = Constants.thirdPlaceColor
        } else {
            pointsView.backgroundColor  = Constants.secondColor?.withAlphaComponent(0.15)
        }
    }
}

// MARK: - UI Configuration
extension PlayerStatsCell {
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        selectionStyle = .none
        
        configurePlayerPlaceLabel()
        configurePointsView()
        configurePlayerNameView()
        configureViewsTexts()
    }
    
    private func configureViewsTexts() {
        configureViewText(in: pointsView, withLabel: pointsLabel)
        configurePlayerNameLabel()
    }
    
    private func configureViewText(in view: UIView, withLabel label: UILabel) {
        label.font = UIFont(name: "Jellee-Roman", size: 18)
        
        view.addSubview(label)
        label.pinCenter(to: view)
    }
    
    private func configureCorners() {
        pointsView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        playerNameView.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
        
        separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private func configurePlayerPlaceLabel() {
        playerPlaceLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        addSubview(playerPlaceLabel)
        playerPlaceLabel.setWidth(13)
        playerPlaceLabel.pinLeft(to: self, 0)
        playerPlaceLabel.pinCenterY(to: self)
    }
    
    private func configurePointsView() {
        addSubview(pointsView)
        pointsView.pinLeft(to: playerPlaceLabel.trailingAnchor, 8)
        pointsView.setWidth(UIScreen.main.bounds.width * 0.14)
        pointsView.pinVertical(to: self, 2)
    }
    
    private func configurePlayerNameView() {
        playerNameView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.15)
        
        addSubview(playerNameView)
        playerNameView.pinLeft(to: pointsView.trailingAnchor, 4)
        playerNameView.pinRight(to: self, 0)
        playerNameView.pinVertical(to: self, 2)
    }
    
    private func configurePlayerNameLabel() {
        playerNameLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        addSubview(playerNameLabel)
        playerNameLabel.pinLeft(to: playerNameView.leadingAnchor, 10)
        playerNameLabel.pinWidth(to: playerNameView)
        playerNameLabel.pinCenterY(to: centerYAnchor)
    }
}
