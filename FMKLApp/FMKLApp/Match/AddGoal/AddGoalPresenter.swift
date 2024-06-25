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
    
//    func continuteButtonTapped(code: String) {
//        guard code != "" else {
//            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Referee code can't be empty!")
//            return
//        }
//        self.view?.mainVC?.presenter?.continueButtonTapped(for: code)
//    }
}
