//
//  SettingsPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import Foundation

final class SettingsPresenter {
    private weak var view: SettingsViewController?
    private var router: SettingsRouter
    
    init(view: SettingsViewController?, router: SettingsRouter) {
        self.view = view
        self.router = router
    }
    
    func backButtonTapped() {
        router.navigateToMain()
    }
}
