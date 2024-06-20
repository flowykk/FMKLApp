//
//  DevInfoPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.06.2024.
//

import UIKit

final class DevInfoPresenter {
    private weak var view: DevInfoViewController?
    private var router: DevInfoRouter
    
    init(view: DevInfoViewController?, router: DevInfoRouter) {
        self.view = view
        self.router = router
    }
    
    func instButtonTapped() {
        router.showSocialMedia(
            appUrl: "instagram://user?username=",
            webUrl: "https://instagram.com/"
        )
    }
    
    func tgButtonTapped() {
        router.showSocialMedia(
            appUrl: "tg://resolve?domain=",
            webUrl: "https://t.me/"
        )
    }

}
