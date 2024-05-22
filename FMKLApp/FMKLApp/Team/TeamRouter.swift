//
//  TeamRouter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.05.2024.
//

import UIKit

final class TeamRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    func navigateToMain() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToAvatarPreview(with image: UIImage) {
        let vc = PreviewAvatarBuilder.build(with: image)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        view?.present(vc, animated: true)
    }
}
