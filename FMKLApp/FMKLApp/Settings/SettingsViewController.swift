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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        view.backgroundColor = Constants.backgroundColor
        
        configureUI()
    }
    
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
}

extension SettingsViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureSettingsButton()
    }
    
    private func configureTitleView() {
        titleView.text = "Settings"
        titleView.font = UIFont(name: "Jellee-Roman", size: 16)
        titleView.textColor = Constants.accentColor
    }
    
    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = titleView
    }
    
    private func configureSettingsButton() {
        let largeFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Constants.accentColor
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
