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
    private var team1Score: Int? = nil
    private var team2Score: Int? = nil
    private var lastGoalAuthor: String? = nil
    private var lastCardAuthor: String? = nil
    
    private var goalAdded: Bool = false
    
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
    
    private func teamNamesEmpty() -> Bool {
        team1Name = firstPickerView?.getTextFieldData()
        team2Name = secondPickerView?.getTextFieldData()
        
        return team1Name == nil || team2Name == nil || team1Name == "" || team2Name == "" || team1Name == team2Name
    }
    
    func toggleGoalAdded() {
        goalAdded.toggle()
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
        if teamNamesEmpty() {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Team Names can't be empty!")
        }
        
        router.presentAddGoalView()
    }
    
    func addCardButtonTapped() {
        if teamNamesEmpty() {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Team Names can't be empty!")
        }
        
        router.presentAddCardView()
    }
    
    func addGoalToTable(withGoal goal: Goal) {
        if let addGoalVC = view?.presentedViewController {
            addGoalVC.dismiss(animated: true)
        }
        
        toggleGoalAdded()
        updateTrackingMatchTeamScores(withGoal: goal)
        goalsTableView?.addRow(withGoal: goal)
    }
    
    func addCardToTable(withCard card: PlayerCard) {
        if let addCardVC = view?.presentedViewController {
            addCardVC.dismiss(animated: true)
        }
        
        updateTrackingMatchCard(withCard: card)
        cardsTableView?.addRow(withCard: card)
    }
    
    func startTrackingMatch() {
        startTime = .now
        
        let attributes = MatchTrackingAttributes()
        let state = MatchTrackingAttributes.ContentState(
            startTime: startTime!
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
            team2Score: team2Score,
            lastGoalAuthor: lastGoalAuthor,
            lastCardAuthor: lastCardAuthor
        )
        let content = ActivityContent(state: state, staleDate: nil)
                
        Task {
            await activity?.update(content)
        }
    }
    
    func updateTrackingMatchTeamScores(withGoal goal: Goal) {
        guard let startTime else { return }
        guard let team1Name else { return }
        guard let team2Name else { return }
        guard goalAdded else { return }
        
        let shortTeam1Name = TeamNames.names[team1Name]
        let shortTeam2Name = TeamNames.names[team2Name]
        
        var state = MatchTrackingAttributes.ContentState(
            startTime: startTime,
            team1Name: TeamNames.names[team1Name],
            team2Name: TeamNames.names[team2Name],
            team1Score: team1Score,
            team2Score: team2Score,
            lastGoalAuthor: lastGoalAuthor,
            lastCardAuthor: lastCardAuthor
        )
        
        if shortTeam1Name != nil && goal.scoredTeamName == shortTeam1Name {
            team1Score = (team1Score == nil ? 0 : team1Score!) + 1
            state.team1Score = team1Score
        } else if shortTeam2Name != nil && goal.scoredTeamName == shortTeam2Name {
            team2Score = (team2Score == nil ? 0 : team2Score!) + 1
            state.team2Score = team2Score
        }
        lastGoalAuthor = goal.scoredPlayer
        state.lastGoalAuthor = lastGoalAuthor
        goalAdded = false
                
        let content = ActivityContent(state: state, staleDate: nil)
                
        Task {
            await activity?.update(content)
        }
    }
    
    func updateTrackingMatchCard(withCard card: PlayerCard) {
        guard let startTime else { return }
        guard let team1Name else { return }
        guard let team2Name else { return }
        
        lastCardAuthor = card.player
        let state = MatchTrackingAttributes.ContentState(
            startTime: startTime,
            team1Name: TeamNames.names[team1Name],
            team2Name: TeamNames.names[team2Name],
            team1Score: team1Score,
            team2Score: team2Score,
            lastGoalAuthor: lastGoalAuthor,
            lastCardAuthor: lastCardAuthor
        )
        let content = ActivityContent(state: state, staleDate: nil)
         
        Task {
            await activity?.update(content)
        }
    }
}
