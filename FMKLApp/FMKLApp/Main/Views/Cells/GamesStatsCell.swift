//
//  GamesStatsCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 17.05.2024.
//

import UIKit

final class GamesStatsCell: UITableViewCell {
    weak var presenter: MainPresenter?
    
    private let teamPlaceLabel: UILabel = UILabel()
    
    private let pointsView: UIView = UIView()
    private let pointsLabel: UILabel = UILabel()
    
    private let teamNameView: UIView = UIView()
    private let teamNameLabel: UILabel = UILabel()
    
    private let winsView: UIView = UIView()
    private let winsLabel: UILabel = UILabel()
    
    private let losesView: UIView = UIView()
    private let losesLabel: UILabel = UILabel()
    
    private let scoredGoalsView: UIView = UIView()
    private let scoredGoalsLabel: UILabel = UILabel()
    
    private let missedGoalsView: UIView = UIView()
    private let missedGoalsLabel: UILabel = UILabel()
    
    private let viewTeamButton: UIButton = UIButton()
    private let viewTeamLabel: UILabel = UILabel()
    
    private var teamName: String = String()
    
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

extension GamesStatsCell {
    func set(teamPlace: Int, teamStats: TeamGamesStats) {
        teamPlaceLabel.text     = String(teamPlace)
        pointsLabel.text        = String(teamStats.points)
        teamNameLabel.text      = teamStats.teamName
        teamName                = teamStats.fullTeamName
        winsLabel.text          = String(teamStats.wins)
        losesLabel.text         = String(teamStats.loses)
        scoredGoalsLabel.text   = String(teamStats.goalsScored)
        missedGoalsLabel.text   = String(teamStats.goalsMissed)
        
        teamPlaceLabel.textColor    = Constants.secondColor
        pointsLabel.textColor       = Constants.secondColor
        teamNameLabel.textColor     = Constants.secondColor
        winsLabel.textColor         = Constants.secondColor
        losesLabel.textColor        = Constants.secondColor
        scoredGoalsLabel.textColor  = Constants.secondColor
        missedGoalsLabel.textColor  = Constants.secondColor
        
        if teamPlace == 1 {
            pointsView.backgroundColor  = Constants.firstPlaceColor
        } else if teamPlace == 2 {
            pointsView.backgroundColor  = Constants.secondPlaceColor
        } else if teamPlace == 3 {
            pointsView.backgroundColor  = Constants.thirdPlaceColor
        } else if teamPlace > 4 {
            pointsView.backgroundColor  = Constants.secondColor?.withAlphaComponent(0.15)
            
            teamPlaceLabel.textColor    = Constants.eliminationColor
            pointsLabel.textColor       = Constants.eliminationColor
            teamNameLabel.textColor     = Constants.eliminationColor
            winsLabel.textColor         = Constants.eliminationColor
            losesLabel.textColor        = Constants.eliminationColor
            scoredGoalsLabel.textColor  = Constants.eliminationColor
            missedGoalsLabel.textColor  = Constants.eliminationColor
        } else {
            pointsView.backgroundColor  = Constants.secondColor?.withAlphaComponent(0.15)
        }
    }
    
    @objc
    private func viewTeamButtonTapped() {
        presenter?.viewTeamButtonTapped(forFullName: teamName, withShortName: teamNameLabel.text!)
    }
}

extension GamesStatsCell {
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        selectionStyle = .none
        
        configureTeamPlaceLabel()
        configurePointsView()
        configureTeamNameView()
        configureGoalsWinsInfoViews(accentView: winsView, secondaryView: teamNameView)
        configureGoalsWinsInfoViews(accentView: losesView, secondaryView: winsView)
        configureGoalsWinsInfoViews(accentView: scoredGoalsView, secondaryView: losesView)
        configureGoalsWinsInfoViews(accentView: missedGoalsView, secondaryView: scoredGoalsView)
        configureViewTeamButton()
        configureViewsTexts()
    }
    
    private func configureViewsTexts() {
        configureViewText(in: pointsView, withLabel: pointsLabel)
        configureViewText(in: teamNameView, withLabel: teamNameLabel)
        configureViewText(in: winsView, withLabel: winsLabel)
        configureViewText(in: losesView, withLabel: losesLabel)
        configureViewText(in: scoredGoalsView, withLabel: scoredGoalsLabel)
        configureViewText(in: missedGoalsView, withLabel: missedGoalsLabel)
    }
    
    private func configureViewText(in view: UIView, withLabel label: UILabel) {
        label.font = UIFont(name: "Jellee-Roman", size: 18)
        
        view.addSubview(label)
        label.pinCenter(to: view)
    }
    
    private func configureCorners() {
        pointsView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        teamNameView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        
        winsView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        losesView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        scoredGoalsView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        missedGoalsView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        
        viewTeamButton.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
        
        separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private func configureTeamPlaceLabel() {
        teamPlaceLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        
        addSubview(teamPlaceLabel)
        teamPlaceLabel.setWidth(13)
        teamPlaceLabel.pinLeft(to: self, 0)
        teamPlaceLabel.pinCenterY(to: self)
    }
    
    private func configurePointsView() {
        addSubview(pointsView)
        pointsView.pinLeft(to: teamPlaceLabel.trailingAnchor, 8)
        pointsView.setWidth(UIScreen.main.bounds.width * 0.14)
        pointsView.pinVertical(to: self, 2)
    }
    
    private func configureTeamNameView() {
        teamNameView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.15)
        
        addSubview(teamNameView)
        teamNameView.pinLeft(to: pointsView.trailingAnchor, 4)
        teamNameView.setWidth(UIScreen.main.bounds.width * 0.2)
        teamNameView.pinVertical(to: self, 2)
    }
    
    private func configureGoalsWinsInfoViews(accentView: UIView, secondaryView: UIView) {
        accentView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.15)
        
        addSubview(accentView)
        accentView.pinLeft(to: secondaryView.trailingAnchor, 4)
        accentView.setWidth(UIScreen.main.bounds.width * 0.09)
        accentView.pinVertical(to: self, 2)
    }
    
    private func configureViewTeamButton() {
        viewTeamButton.backgroundColor = Constants.accentColor
        viewTeamButton.addTarget(self, action: #selector(viewTeamButtonTapped), for: .touchUpInside)
        
        let largeFont = UIFont.systemFont(ofSize: 18, weight: .black)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        viewTeamButton.setImage(image, for: .normal)
        viewTeamButton.tintColor = Constants.backgroundColor
        
        contentView.addSubview(viewTeamButton)
        viewTeamButton.pinLeft(to: missedGoalsView.trailingAnchor, 4)
        viewTeamButton.pinRight(to: trailingAnchor, 0)
        viewTeamButton.pinVertical(to: self, 2)
    }
}
