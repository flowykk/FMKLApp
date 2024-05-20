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
}
