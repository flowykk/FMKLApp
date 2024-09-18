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
    private var activity: Activity<TimeTrackingAttributes>? = nil
    
    private weak var view: MatchViewController?
    
    weak var goalsTableView: GoalsTableView?
    weak var cardsTableView: AddCardTableView?
    
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
        
        let attributes = TimeTrackingAttributes()
        let state = TimeTrackingAttributes.ContentState(startTime: .now)
        let content = ActivityContent(state: state, staleDate: nil)
        
        activity = try? Activity<TimeTrackingAttributes>.request(attributes: attributes, content: content, pushType: nil)
    }
    
    func stopTrackingMatch() {
        guard let startTime else { return }
        
        let state = TimeTrackingAttributes.ContentState(startTime: startTime)
        let content = ActivityContent(state: state, staleDate: nil)
        
        Task {
            await activity?.end(content, dismissalPolicy: .immediate)
        }
    }
}
