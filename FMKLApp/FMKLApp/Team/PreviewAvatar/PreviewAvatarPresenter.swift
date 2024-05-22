//
//  PreviewAvatarPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class PreviewAvatarPresenter {
    private weak var view: PreviewAvatarViewController?
    private var router: PreviewAvatarRouter
    
    init(view: PreviewAvatarViewController?, router: PreviewAvatarRouter) {
        self.view = view
        self.router = router
    }
        
}
