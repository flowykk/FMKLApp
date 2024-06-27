//
//  SettingsViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    var presenter: SettingsPresenter?
    
    private let titleView: UILabel = UILabel()
    
    private let appIconLabel: UILabel = UILabel()
    private var appIconCollectionView: AppIconCollectionView = AppIconCollectionView()
    
    private let developerInfoLabel: UILabel = UILabel()
    private let developerInfoTable: PrimaryTableView = PrimaryTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        view.backgroundColor = Constants.backgroundColor
        
        developerInfoTable.presenter = presenter
        appIconCollectionView.presenter = presenter
        presenter?.collectionView = appIconCollectionView
        
        configureUI()
    }
}

// MARK: - Class functions
extension SettingsViewController {
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
}

// MARK: - UI Configuration
extension SettingsViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureBackButton()
        
        configureAppIconLabel()
        configureAppIconCollectionView()
        
        configureDeveloperInfoLabel()
        configureDeveloperInfoTable()
    }
    
    private func configureTitleView() {
        titleView.text = "Settings"
        titleView.font = UIFont(name: "Jellee-Roman", size: 17)
        titleView.textColor = Constants.accentColor
    }
    
    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = titleView
    }
    
    private func configureBackButton() {
        let largeFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Constants.accentColor
    }
    
    private func configureAppIconLabel() {
        appIconLabel.text = "App icon"
        appIconLabel.font = UIFont(name: "Jellee-Roman", size: 15)
        appIconLabel.textColor = Constants.accentColor
        
        view.addSubview(appIconLabel)
        appIconLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5)
        appIconLabel.pinLeft(to: view.leadingAnchor, 20)
    }
    
    private func configureAppIconCollectionView() {
        view.addSubview(appIconCollectionView)
        appIconCollectionView.pinLeft(to: view.leadingAnchor, 20)
        appIconCollectionView.pinRight(to: view.trailingAnchor, 20)
        appIconCollectionView.pinTop(to: appIconLabel.bottomAnchor, 5)
    }
    
    private func configureDeveloperInfoLabel() {
        developerInfoLabel.text = "Developer info"
        developerInfoLabel.font = UIFont(name: "Jellee-Roman", size: 15)
        developerInfoLabel.textColor = Constants.accentColor
        
        view.addSubview(developerInfoLabel)
        developerInfoLabel.pinTop(to: appIconCollectionView.bottomAnchor, 20)
        developerInfoLabel.pinLeft(to: view.leadingAnchor, 20)
    }
    
    private func configureDeveloperInfoTable() {
        view.addSubview(developerInfoTable)
        developerInfoTable.pinLeft(to: view.leadingAnchor, 20)
        developerInfoTable.pinRight(to: view.trailingAnchor, 20)
        developerInfoTable.pinTop(to: developerInfoLabel.bottomAnchor, 5)
    }
}

// MARK: - UINavigationControllerDelegate
extension SettingsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            if toVC is MainViewController {
                return PopTransitioning()
            }
        }
        return nil
    }
}
