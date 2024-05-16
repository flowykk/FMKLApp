//
//  MainViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class MainViewController: UIViewController {
    var presenter: MainPresenter?
    
    private let titleView: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        view.backgroundColor = Constants.backgroundColor
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    @objc
    private func settingsButtonTapped() {
        presenter?.settingsButtonTapped()
    }
}

extension MainViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureSettingsButton()
    }
    
    private func configureTitleView() {
        titleView.text = "FMKL"
        titleView.font = UIFont(name: "Jellee-Roman", size: 16)
        titleView.textColor = Constants.accentColor
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = titleView
    }
    
    private func configureSettingsButton() {
        let largeFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "gearshape.fill", withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Constants.accentColor
    }
}

// MARK: - UINavigationControllerDelegate
extension MainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if toVC is SettingsViewController {
                return PushTransitioning()
            }
        }
        return nil
    }
}
