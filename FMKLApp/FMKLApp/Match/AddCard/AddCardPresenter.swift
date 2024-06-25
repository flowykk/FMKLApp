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
        guard card.player != "",
              card.team != ""
        else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Data can't be empty!")
            return
        }
        
        guard card.minute > 0 else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Match's minute must be a positive number!")
            return
        }
        
        self.view?.matchVC?.presenter?.addCardToTable(withCard: card)
    }
}
