//
//  MatchPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit
import Foundation
import ActivityKit

final class MatchPresenter {
    private var startTime: Date? = nil
    private var team1Name: String? = nil
    private var team2Name: String? = nil
    private var team1Score: Int = 0
    private var team2Score: Int = 0
    private var lastGoalAuthor: String? = nil
    private var lastCardAuthor: String? = nil
    
    private var activity: Activity<MatchTrackingAttributes>? = nil
    
    private weak var view: MatchViewController?
    
    weak var goalsTableView: GoalsTableView?
    weak var cardsTableView: AddCardTableView?
    
    weak var firstPickerView: TextFieldPickerView?
    weak var secondPickerView: TextFieldPickerView?
    
    private var router: MatchRouter
    
    init(view: MatchViewController?, router: MatchRouter) {
        self.view = view
        self.router = router
    }
    
    func backButtonTapped() {
        router.navigateToMain()
    }
    
    func infoButtonTapped() {
        AlertHelper.showAlert(
            from: view,
            withTitle: "Warning",
            message: "Be careful when entering values! Invalid or incorrect values on this screen will cause punishment for referee."
        )
    }
    
    func continueButtonTapped() {
        stopTrackingMatch()
        startTime = nil
        router.navigateToMain()
    }
    
    func addGoalButtonTapped() {
        router.presentAddGoalView()
    }
    
    func addCardButtonTapped() {
        router.presentAddCardView()
    }
    
    func addGoalToTable(withGoal goal: Goal) {
        if let addGoalVC = view?.presentedViewController {
            addGoalVC.dismiss(animated: true)
        }
        
        goalsTableView?.addRow(withGoal: goal)
    }
    
    func addCardToTable(withCard card: PlayerCard) {
        if let addCardVC = view?.presentedViewController {
            addCardVC.dismiss(animated: true)
        }
        
        cardsTableView?.addRow(withCard: card)
    }
    
    func startTrackingMatch() {
        startTime = .now
        
        let attributes = MatchTrackingAttributes()
        let state = MatchTrackingAttributes.ContentState(
            startTime: startTime!,
            team1Score: 0,
            team2Score: 0
        )
        let content = ActivityContent(state: state, staleDate: nil)
                
        activity = try? Activity<MatchTrackingAttributes>.request(attributes: attributes, content: content, pushType: nil)
    }
    
    func stopTrackingMatch() {
        guard let startTime else { return }
        guard let lastGoalAuthor else { return }
        guard let lastCardAuthor else { return }
        
        let state = MatchTrackingAttributes.ContentState(
            startTime: startTime,
            team1Name: team1Name,
            team2Name: team2Name,
            team1Score: team1Score,
            team2Score: team2Score,
            lastGoalAuthor: lastGoalAuthor,
            lastCardAuthor: lastCardAuthor
        )
        let content = ActivityContent(state: state, staleDate: nil)
        
        Task {
            await activity?.end(content, dismissalPolicy: .immediate)
        }
    }
    
    func updateTrackingMatchTeamNames() {
        guard let startTime else { return }
        team1Name = firstPickerView?.getTextFieldData()
        team2Name = secondPickerView?.getTextFieldData()
        
        let state = MatchTrackingAttributes.ContentState(
            startTime: startTime,
            team1Name: TeamNames.names[team1Name!],
            team2Name: TeamNames.names[team2Name!],
            team1Score: team1Score,
            team2Score: team2Score
        )
        let content = ActivityContent(state: state, staleDate: nil)
        
        print(state)
        
        Task {
            await activity?.update(content)
        }
    }
}
