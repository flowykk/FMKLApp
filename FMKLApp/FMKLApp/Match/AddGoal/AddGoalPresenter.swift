//
//  AddGoalPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 25.06.2024.
//

import UIKit

final class AddGoalPresenter {
    private weak var view: AddGoalViewController?
    private var router: AddGoalRouter
    
    init(view: AddGoalViewController?, router: AddGoalRouter) {
        self.view = view
        self.router = router
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
        
        self.view?.matchVC?.presenter?.addGoalToTable(withGoal: goal)
    }
}
