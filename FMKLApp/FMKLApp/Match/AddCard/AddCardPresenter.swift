//
//  AddCardPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 25.06.2024.
//

import UIKit

final class AddCardPresenter {
    private weak var view: AddCardViewController?
    
    init(view: AddCardViewController?) {
        self.view = view
    }
    
    func continuteButtonTapped(withCard card: PlayerCard) {
        guard card.player != "", card.team != "" else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Data can't be empty!")
            return
        }
        
        guard card.minute > 0 else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Match's minute must be a positive number!")
            return
        }
        
        let shortTeam1Name = TeamNames.names[(view?.matchVC?.presenter?.firstPickerView?.getTextFieldData())!]
        let shortTeam2Name = TeamNames.names[(view?.matchVC?.presenter?.secondPickerView?.getTextFieldData())!]
        
        if  shortTeam1Name != card.team && shortTeam2Name != card.team {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Scored Team must be equal to Team 1 or Team 2!")
            return
        }
        
        self.view?.matchVC?.presenter?.addCardToTable(withCard: card)
    }
}
