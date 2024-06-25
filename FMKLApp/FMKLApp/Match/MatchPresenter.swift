//
//  MatchPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

final class MatchPresenter {
    private weak var view: MatchViewController?
    weak var goalsTableView: GoalsTableView?
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
    
    func addGoalToTable(withGoal goal: Goal) {
        if let addGoalVC = view?.presentedViewController {
            addGoalVC.dismiss(animated: true)
        }
        
        goalsTableView?.addRow(withGoal: goal)
    }
}
