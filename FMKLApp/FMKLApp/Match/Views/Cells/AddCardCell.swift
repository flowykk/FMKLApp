//
//  AddCardCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

final class AddCardCell: UITableViewCell {
    private let teamNameView: UIView = UIView()
    private let teamNameLabel: UILabel = UILabel()
    
    private let PlayerNameView: UIView = UIView()
    private let PlayerNameLabel: UILabel = UILabel()
    
    private let cardView: UIView = UIView()
    private let card: DefaultCardView = DefaultCardView()
    
    private let minuteView: UIView = UIView()
    private let minuteLabel: UILabel = UILabel()
    
    private let deleteRowButton: UIButton = UIButton()
    
    var deleteButtonTapAction: (() -> Void)?
        
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
    
    func set(card: PlayerCard) {
        self.card.set(isRed: card.isCardRed)
        
        teamNameLabel.text                  = card.team
        PlayerNameLabel.text                = card.player
        minuteLabel.text                    = String(card.minute) + "’"
        
        teamNameLabel.textColor             = Constants.backgroundColor
        PlayerNameLabel.textColor           = Constants.secondColor
        minuteLabel.textColor               = Constants.secondColor
        
        teamNameView.backgroundColor        = Constants.accentColor
    }
    
    @objc
    private func deleteRowButtonTapped() {
        deleteButtonTapAction?()
    }
}

extension AddCardCell {
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        selectionStyle = .none
        
        configureTeamNameView()
        configureScoredPlayerNameView()
        configureAssistedPlayerNameView()
        configureMinuteView()
        configureCardView()
        configureDeleteRowButton()
        
        configureViewsTexts()
    }
    
    private func configureViewsTexts() {
        configureViewText(in: teamNameView, withLabel: teamNameLabel)
        configureViewText(in: minuteView, withLabel: minuteLabel)

        PlayerNameLabel.font = UIFont(name: "Jellee-Roman", size: 14)
        
        PlayerNameView.addSubview(PlayerNameLabel)
        PlayerNameLabel.pinVertical(to: PlayerNameView)
        PlayerNameLabel.pinLeft(to: PlayerNameView.leadingAnchor, 10)
    }
    
    private func configureViewText(in view: UIView, withLabel label: UILabel) {
        label.font = UIFont(name: "Jellee-Roman", size: 14)
        
        view.addSubview(label)
        label.pinCenter(to: view)
    }
    
    private func configureCorners() {
        teamNameView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        PlayerNameView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        cardView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        minuteView.roundCorners(topLeft: 5, topRight: 5, bottomRight: 5, bottomLeft: 5)
        deleteRowButton.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
        
        separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private func configureTeamNameView() {
        addSubview(teamNameView)
        teamNameView.pinLeft(to: leadingAnchor, 0)
        teamNameView.setWidth(UIScreen.main.bounds.width * 0.18)
        teamNameView.pinVertical(to: self, 2)
    }
    
    private func configureScoredPlayerNameView() {
        PlayerNameView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(PlayerNameView)
        PlayerNameView.pinLeft(to: teamNameView.trailingAnchor, 4)
        PlayerNameView.setWidth(UIScreen.main.bounds.width * 0.40)
        PlayerNameView.pinVertical(to: self, 2)
    }
    
    private func configureAssistedPlayerNameView() {
        cardView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(cardView)
        cardView.pinLeft(to: PlayerNameView.trailingAnchor, 4)
        cardView.setWidth(UIScreen.main.bounds.width * 0.12)
        cardView.pinVertical(to: self, 2)
    }
    
    private func configureMinuteView() {
        minuteView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.10)
        
        addSubview(minuteView)
        minuteView.pinLeft(to: cardView.trailingAnchor, 4)
        minuteView.setWidth(UIScreen.main.bounds.width * 0.09)
        minuteView.pinVertical(to: self, 2)
    }
    
    private func configureDeleteRowButton() {
        deleteRowButton.backgroundColor = Constants.eliminationColor
        deleteRowButton.addTarget(self, action: #selector(deleteRowButtonTapped), for: .touchUpInside)
        
        let largeFont = UIFont.systemFont(ofSize: 18, weight: .black)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "minus.circle.fill", withConfiguration: configuration)
        deleteRowButton.setImage(image, for: .normal)
        deleteRowButton.tintColor = .white
        
        contentView.addSubview(deleteRowButton)
        deleteRowButton.pinLeft(to: minuteView.trailingAnchor, 4)
        deleteRowButton.pinRight(to: trailingAnchor, 0)
        deleteRowButton.pinVertical(to: self, 2)
    }
    
    private func configureCardView() {
        cardView.addSubview(card)
        card.pinCenter(to: cardView)
    }
}
