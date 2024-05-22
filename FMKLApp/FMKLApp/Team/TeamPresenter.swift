//
//  TeamPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.05.2024.
//

import UIKit

final class TeamPresenter {
    private weak var view: TeamViewController?
    private var router: TeamRouter
    
    init(view: TeamViewController?, router: TeamRouter) {
        self.view = view
        self.router = router
    }
    
    func backButtonTapped() {
        router.navigateToMain()
    }
    
    func goToAvatarPreview(with image: UIImage) {
        router.navigateToAvatarPreview(with: image)
    }
}
