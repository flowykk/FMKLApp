//
//  MatchPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

final class MatchPresenter {
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
}
