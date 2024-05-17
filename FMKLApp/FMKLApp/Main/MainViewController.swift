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
    
    private let fmklImageView: UIImageView = UIImageView()
    private let refereeView: RefereeView = RefereeView()
    
    private let refereeLeftView: UIView = UIView()
    private let refereeLabel: UILabel = UILabel()
    private let refereeWarningLabel: UILabel = UILabel()
    private let refereeGoButton: UIButton = UIButton()
    
    private let group1Label: UILabel = UILabel()
    private let group1TableView: GamesStatsTableView = GamesStatsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        view.backgroundColor = Constants.backgroundColor
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        group1TableView.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        refereeLeftView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        refereeGoButton.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
    }
    
    @objc
    private func settingsButtonTapped() {
        presenter?.settingsButtonTapped()
    }
    
    @objc
    private func goButtonTapped() {
        print("go referee")
    }
}

extension MainViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureSettingsButton()
        
        configureFmklImageView()
        configureRefereeLeftView()
        configureRefereeLabel()
        configureRefereeWarningLabel()
        configureRefereeGoButton()
        
        configureGroup1Label()
        configureGroup1TableView()
    }
    
    private func configureTitleView() {
        titleView.text = "FMKL"
        titleView.font = UIFont(name: "Jellee-Roman", size: 17)
        titleView.textColor = Constants.accentColor
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = titleView
    }
    
    private func configureSettingsButton() {
        let largeFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "gearshape.fill", withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Constants.accentColor
    }
    
    private func configureFmklImageView() {
        fmklImageView.image = UIImage(named: "FMKLmain")
        fmklImageView.contentMode = .scaleAspectFit
        
        let size = UIScreen.main.bounds.width * 0.7
        
        view.addSubview(fmklImageView)
        fmklImageView.pinCenterX(to: view)
        fmklImageView.setWidth(size)
        fmklImageView.setHeight(size)
        fmklImageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, -20)
    }
    
    private func configureRefereeLeftView() {
        refereeLeftView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.2)
        
        view.addSubview(refereeLeftView)
        refereeLeftView.setWidth(UIScreen.main.bounds.width * 0.65)
        refereeLeftView.setHeight(55)
        refereeLeftView.pinTop(to: fmklImageView.bottomAnchor, -10)
        refereeLeftView.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureRefereeLabel() {
        refereeLabel.text = """
        Become a referee
        for the match
        """
        refereeLabel.numberOfLines = 2
        refereeLabel.font = UIFont(name: "Jellee-Roman", size: 16)
        refereeLabel.textColor = Constants.secondColor
        
        refereeLeftView.addSubview(refereeLabel)
        refereeLabel.pinCenterY(to: refereeLeftView)
        refereeLabel.pinLeft(to: refereeLeftView.leadingAnchor, 15)
    }
    
    private func configureRefereeWarningLabel() {
        refereeWarningLabel.text = "You will need a special code from FMKL organizators"
        refereeWarningLabel.numberOfLines = 1
        refereeWarningLabel.font = UIFont(name: "Jellee-Roman", size: 10)
        refereeWarningLabel.textColor = Constants.secondColor?.withAlphaComponent(0.3)
        
        view.addSubview(refereeWarningLabel)
        refereeWarningLabel.pinLeft(to: view.leadingAnchor, 15)
        refereeWarningLabel.pinTop(to: refereeLeftView.bottomAnchor, 5)
    }
    
    private func configureRefereeGoButton() {
        refereeGoButton.backgroundColor = Constants.accentColor
        refereeGoButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        
        let largeFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "sportscourt.fill", withConfiguration: configuration)
        refereeGoButton.setImage(image, for: .normal)
        refereeGoButton.tintColor = Constants.backgroundColor
        
        view.addSubview(refereeGoButton)
        refereeGoButton.setHeight(55)
        refereeGoButton.pinTop(to: fmklImageView.bottomAnchor, -10)
        refereeGoButton.pinLeft(to: refereeLeftView.trailingAnchor, 5)
        refereeGoButton.pinRight(to: view.trailingAnchor, 10)
    }
    
    private func configureGroup1Label() {
        group1Label.text = "Group 1"
        group1Label.font = UIFont(name: "Jellee-Roman", size: 16)
        group1Label.textColor = Constants.accentColor
        
        view.addSubview(group1Label)
        group1Label.pinTop(to: refereeWarningLabel.bottomAnchor, 20)
        group1Label.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureGroup1TableView() {
        group1TableView.presenter = presenter
        
        view.addSubview(group1TableView)
        group1TableView.pinTop(to: group1Label.bottomAnchor, 5)
        group1TableView.pinHorizontal(to: view, 10)
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
