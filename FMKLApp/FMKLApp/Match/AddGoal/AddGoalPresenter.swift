//
//  AddGoalPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 25.06.2024.
//

import UIKit

final class AddGoalPresenter {
    private weak var view: AddGoalViewController?
    
    init(view: AddGoalViewController?) {
        self.view = view
    }
    
    func continuteButtonTapped(withGoal goal: Goal) {
        guard goal.scoredTeamName != "", 
                goal.scoredPlayer != "",
                goal.assistedPlayer != ""
        else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Data can't be empty!")
            return
        }
        
        guard goal.minute > 0 else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Match's minute must be a positive number!")
            return
        }
        
        let shortTeam1Name = TeamNames.names[(view?.matchVC?.presenter?.firstPickerView?.getTextFieldData())!]
        let shortTeam2Name = TeamNames.names[(view?.matchVC?.presenter?.secondPickerView?.getTextFieldData())!]
        
        if  shortTeam1Name != goal.scoredTeamName && shortTeam2Name != goal.scoredTeamName {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Scored Team must be equal to Team 1 or Team 2!")
            return
        }
        
        view?.matchVC?.presenter?.addGoalToTable(withGoal: goal)
    }
}
