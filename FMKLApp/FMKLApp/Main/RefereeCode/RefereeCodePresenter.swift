//
//  RefereeCodePresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.05.2024.
//

import Foundation

final class RefereeCodePresenter {
    private weak var view: RefereeCodeViewController?
    private var router: RefereeCodeRouter
    
    init(view: RefereeCodeViewController?, router: RefereeCodeRouter) {
        self.view = view
        self.router = router
    }
    
    func continuteButtonTapped(code: String) {
        guard code != "" else {
            AlertHelper.showAlert(from: view, withTitle: "Error", message: "Referee code can't be empty!")
            return
        }
        
        self.view?.mainVC?.presenter?.continueButtonTapped(for: code)
    }
}
