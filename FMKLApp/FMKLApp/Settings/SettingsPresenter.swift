//
//  SettingsPresenter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class SettingsPresenter {
    private weak var view: SettingsViewController?
    weak var collectionView: AppIconCollectionView?
    private var router: SettingsRouter
    
    init(view: SettingsViewController?, router: SettingsRouter) {
        self.view = view
        self.router = router
    }
    
    func backButtonTapped() {
        router.navigateToMain()
    }
    
    // MARK: - CollectionView To Presenter
    func appIconSelected(_ icon: AppIcon, at index: Int) {
        if icon == .AppIconBlack {
            UIApplication.shared.setAlternateIconName(nil)
        } else {
            UIApplication.shared.setAlternateIconName(icon.rawValue)
        }
        updateSelection(idnex: index)
    }
    
    func devInfoRowSelected(_ row: PrimaryTableView.DevInfoRow) {
            switch row {
            case .viewInfo:
                router.presentDeveloperInfo()
            }
        }
    
    func updateSelection(idnex: Int) {
        collectionView?.allowsSelection = false
        collectionView?.allowsSelection = true
        collectionView?.updateSelectedCell(at: idnex)
    }
}
