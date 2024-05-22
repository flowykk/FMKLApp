//
//  MainViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class MainViewController: UIViewController {
    var presenter: MainPresenter?
    
    private let appTag: AppTagView = AppTagView()
    private let titleView: UILabel = UILabel()
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    private let fmklImageView: UIImageView = UIImageView()
    private let refereeView: RefereeView = RefereeView()
    
    private let refereeLeftView: UIView = UIView()
    private let refereeLabel: UILabel = UILabel()
    private let refereeWarningLabel: UILabel = UILabel()
    private let refereeGoButton: UIButton = UIButton()
    
    private let group1Label: UILabel = UILabel()
    private var group1TableView: GamesStatsTableView = GamesStatsTableView()
    
    private let group2Label: UILabel = UILabel()
    private var group2TableView: GamesStatsTableView = GamesStatsTableView()
    
    private let scorersLabel: UILabel = UILabel()
    private var scorersTableView: PlayersTableView = PlayersTableView()
    
    private let assistersLabel: UILabel = UILabel()
    private var assistersTableView: PlayersTableView = PlayersTableView()
    
    private let lastUpdateLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        group1TableView = GamesStatsTableView(groupNumber: 1)
        group2TableView = GamesStatsTableView(groupNumber: 2)
        scorersTableView = PlayersTableView(dataNumber: 1)
        assistersTableView = PlayersTableView(dataNumber: 2)
        
        group1TableView.presenter = presenter
        group2TableView.presenter = presenter
                
        view.backgroundColor = Constants.backgroundColor
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        appTag.isHidden = false
        configureAppTagView()
        
        navigationController?.delegate = self
        refereeLeftView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        refereeGoButton.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        appTag.isHidden = true
    }
    
    @objc
    private func settingsButtonTapped() {
        presenter?.settingsButtonTapped()
    }
    
    @objc
    private func goButtonTapped() {
        presenter?.goRefereeButtonTapped()
    }
}

extension MainViewController {
    private func configureUI() {
        configureScrollView()
        configureContentView()
        
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
        
        configureGroup2Label()
        configureGroup2TableView()
        
        configureScorersLabel()
        configureScorersTableView()
        
        configureAssistersLabel()
        configureAssistersTableView()
        
        configureLastUpdateLabel()
    }
    
    private func configureScrollView() {
        scrollView.delaysContentTouches = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = Constants.backgroundColor
        
        view.addSubview(scrollView)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
        scrollView.pinTop(to: view.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
    }
    
    private func configureContentView() {
        contentView.backgroundColor = Constants.backgroundColor
        
        scrollView.addSubview(contentView)
        contentView.pinLeft(to: scrollView.leadingAnchor)
        contentView.pinRight(to: scrollView.trailingAnchor)
        contentView.pinTop(to: scrollView.topAnchor)
        contentView.pinBottom(to: scrollView.bottomAnchor)
        contentView.pinWidth(to: scrollView.widthAnchor)
        contentView.setHeight(1740)
    }
    
    private func configureAppTagView() {
        appTag.backgroundColor = Constants.accentColor
        appTag.layer.cornerRadius = 10.5
        
        self.navigationController?.view.addSubview(appTag)
        appTag.pinCenterX(to: view.centerXAnchor)
        appTag.pinTop(to: view.topAnchor, 11)
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
        
        contentView.addSubview(fmklImageView)
        fmklImageView.pinCenterX(to: contentView)
        fmklImageView.setWidth(size)
        fmklImageView.setHeight(size)
        fmklImageView.pinTop(to: contentView.safeAreaLayoutGuide.topAnchor, -20)
    }
    
    private func configureRefereeLeftView() {
        refereeLeftView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.15)
        
        contentView.addSubview(refereeLeftView)
        refereeLeftView.setWidth(UIScreen.main.bounds.width * 0.65)
        refereeLeftView.setHeight(55)
        refereeLeftView.pinTop(to: fmklImageView.bottomAnchor, -10)
        refereeLeftView.pinLeft(to: contentView.leadingAnchor, 10)
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
        
        contentView.addSubview(refereeWarningLabel)
        refereeWarningLabel.pinLeft(to: contentView.leadingAnchor, 15)
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
        
        contentView.addSubview(refereeGoButton)
        refereeGoButton.setHeight(55)
        refereeGoButton.pinTop(to: fmklImageView.bottomAnchor, -10)
        refereeGoButton.pinLeft(to: refereeLeftView.trailingAnchor, 5)
        refereeGoButton.pinRight(to: contentView.trailingAnchor, 10)
    }
    
    private func configureGroup1Label() {
        group1Label.text = "Group 1"
        group1Label.font = UIFont(name: "Jellee-Roman", size: 16)
        group1Label.textColor = Constants.accentColor
        
        contentView.addSubview(group1Label)
        group1Label.pinTop(to: refereeWarningLabel.bottomAnchor, 30)
        group1Label.pinLeft(to: contentView.leadingAnchor, 10)
    }
    
    private func configureGroup1TableView() {
        contentView.addSubview(group1TableView)
        group1TableView.pinTop(to: group1Label.bottomAnchor, 5)
        group1TableView.pinHorizontal(to: contentView, 10)
    }
    
    private func configureGroup2Label() {
        group2Label.text = "Group 2"
        group2Label.font = UIFont(name: "Jellee-Roman", size: 16)
        group2Label.textColor = Constants.accentColor
        
        contentView.addSubview(group2Label)
        group2Label.pinTop(to: group1TableView.bottomAnchor, 20)
        group2Label.pinLeft(to: contentView.leadingAnchor, 10)
    }
    
    private func configureGroup2TableView() {
        contentView.addSubview(group2TableView)
        group2TableView.pinTop(to: group2Label.bottomAnchor, 5)
        group2TableView.pinHorizontal(to: contentView, 10)
    }
    
    private func configureScorersLabel() {
        scorersLabel.text = "Scorers"
        scorersLabel.font = UIFont(name: "Jellee-Roman", size: 16)
        scorersLabel.textColor = Constants.accentColor
        
        contentView.addSubview(scorersLabel)
        scorersLabel.pinTop(to: group2TableView.bottomAnchor, 20)
        scorersLabel.pinLeft(to: contentView.leadingAnchor, 10)
    }
    
    private func configureScorersTableView() {
        contentView.addSubview(scorersTableView)
        scorersTableView.pinTop(to: scorersLabel.bottomAnchor, 5)
        scorersTableView.pinHorizontal(to: contentView, 10)
    }
    
    private func configureAssistersLabel() {
        assistersLabel.text = "Assisters"
        assistersLabel.font = UIFont(name: "Jellee-Roman", size: 16)
        assistersLabel.textColor = Constants.accentColor
        
        contentView.addSubview(assistersLabel)
        assistersLabel.pinTop(to: scorersTableView.bottomAnchor, 20)
        assistersLabel.pinLeft(to: contentView.leadingAnchor, 10)
    }
    
    private func configureAssistersTableView() {
        contentView.addSubview(assistersTableView)
        assistersTableView.pinTop(to: assistersLabel.bottomAnchor, 5)
        assistersTableView.pinHorizontal(to: contentView, 10)
    }
    
    private func configureLastUpdateLabel() {
        lastUpdateLabel.text = "Table last updated 05.05.2024 at 16:13"
        lastUpdateLabel.font = UIFont(name: "Jellee-Roman", size: 12)
        lastUpdateLabel.textColor = Constants.secondColor?.withAlphaComponent(0.3)
        lastUpdateLabel.textAlignment = .center
        
        contentView.addSubview(lastUpdateLabel)
        lastUpdateLabel.pinCenterX(to: contentView)
        lastUpdateLabel.pinTop(to: assistersTableView.bottomAnchor, 20)
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
