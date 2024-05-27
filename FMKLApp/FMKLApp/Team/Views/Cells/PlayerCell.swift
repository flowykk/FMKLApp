//
//  PlayerCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 27.05.2024.
//

import UIKit

class PlayerCell: UITableViewCell {
    private let teamPlaceLabel: UILabel = UILabel()
    
    private let rankView: UIView = UIView()
    private let rankLabel: UILabel = UILabel()
    
    private let playerNameView: UIView = UIView()
    private let playerImageView: UIImageView = UIImageView()
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
    
    func set(playerNumber: Int, player: Player) {
        teamPlaceLabel.text     = String(playerNumber)
        rankLabel.text        = player.rank
        playerNameLabel.text    = player.name
        
        teamPlaceLabel.textColor    = Constants.secondColor
        rankLabel.textColor       = Constants.secondColor
        playerNameLabel.textColor   = Constants.secondColor
    }
}

extension PlayerCell {
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        selectionStyle = .none
        
        configureTeamPlaceLabel()
        
        configureRankView()
        configureRankLabel()
        
        configurePlayerNameView()
        configurePlayerImageView()
        configurePlayerNameLabel()
    }
    
    private func configureCorners() {
        rankView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        playerNameView.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
        
        separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private func configureTeamPlaceLabel() {
        teamPlaceLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        addSubview(teamPlaceLabel)
        teamPlaceLabel.setWidth(13)
        teamPlaceLabel.pinLeft(to: self, 0)
        teamPlaceLabel.pinCenterY(to: self)
    }
    
    private func configureRankView() {
        rankView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(rankView)
        rankView.pinLeft(to: teamPlaceLabel.trailingAnchor, 8)
        rankView.setWidth(UIScreen.main.bounds.width * 0.12)
        rankView.pinVertical(to: self, 2)
    }
    
    private func configureRankLabel() {
        rankLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        rankView.addSubview(rankLabel)
        rankLabel.pinCenter(to: rankView)
    }
    
    private func configurePlayerNameView() {
        playerNameView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(playerNameView)
        playerNameView.pinLeft(to: rankView.trailingAnchor, 4)
        playerNameView.pinRight(to: self, 0)
        playerNameView.pinVertical(to: self, 2)
    }
    
    private func configurePlayerImageView() {
        playerImageView.image = UIImage(named: "BUSUS")
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        
        let width = UIScreen.main.bounds.width * 0.08
        playerImageView.layer.cornerRadius = width / 2
        
        playerNameView.addSubview(playerImageView)
        playerImageView.setWidth(width)
        playerImageView.setHeight(width)
        playerImageView.pinLeft(to: playerNameView.leadingAnchor, 7)
        playerImageView.pinCenterY(to: playerNameView)
    }
    
    private func configurePlayerNameLabel() {
        playerNameLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        playerNameView.addSubview(playerNameLabel)
        playerNameLabel.pinLeft(to: playerImageView.trailingAnchor, 10)
        playerNameLabel.pinWidth(to: playerNameView)
        playerNameLabel.pinCenterY(to: centerYAnchor)
    }
}


