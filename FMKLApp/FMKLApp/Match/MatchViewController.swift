//
//  MatchViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class MatchViewController: UIViewController, UITextFieldDelegate {
    var presenter: MatchPresenter?
        
    private let titleView: UILabel = UILabel()
    
    private let refereeWarningLabel: UILabel = UILabel()
    
    private let firstTeamLabel: UILabel = UILabel()
    private let firstTeamTextFieldPickerView: TextFieldPickerView = TextFieldPickerView()
    
    private let secondTeamLabel: UILabel = UILabel()
    private let secondTeamTextFieldPickerView: TextFieldPickerView = TextFieldPickerView()
    
    private let tablesWarningLabel: UILabel = UILabel()
    private let goalsLabel: UILabel = UILabel()
    private let goalsTableView: GoalsTableView = GoalsTableView()
    
    private let cardsLabel: UILabel = UILabel()
    private let cardsTableView: AddCardTableView = AddCardTableView()
    
    private let continueButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        presenter?.startTrackingMatch()
        
        goalsTableView.presenter = presenter
        presenter?.goalsTableView = goalsTableView
        
        cardsTableView.presenter = presenter
        presenter?.cardsTableView = cardsTableView
        
        firstTeamTextFieldPickerView.presenter = presenter
        presenter?.firstPickerView = firstTeamTextFieldPickerView
        
        secondTeamTextFieldPickerView.presenter = presenter
        presenter?.secondPickerView = secondTeamTextFieldPickerView
        
        fetchDataForTeam1PickerView()
        fetchDataForTeam2PickerView()
        
        configureUI()
    }
}

// MARK: - Class functions
extension MatchViewController {
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc
    private func infoButtonTapped() {
        presenter?.infoButtonTapped()
    }
    
    @objc
    private func continueButtonTapped() {
        presenter?.continueButtonTapped()
    }
}

// MARK: - UI Configuration
extension MatchViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureBackButton()
        configureInfoButton()
        
        configureRefereeWarningLabel()
        
        configureFirstTeamLabel()
        configureFirstTeamTextFieldPickerView()
        
        configureSecondTeamLabel()
        configureSecondTeamTextFieldPickerView()
        
        configureTablesWarningLabel()
        configureGoalsLabel()
        configureGoalsTableView()
        
        configureCardsLabel()
        configureCardsTableView()
        
        configureContinueButton()
    }
    
    private func configureTitleView() {
        titleView.text = "Match"
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
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Constants.accentColor
    }
    
    private func configureInfoButton() {
        let largeFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "info.circle", withConfiguration: configuration)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Constants.eliminationColor
    }
    
    private func configureRefereeWarningLabel() {
        refereeWarningLabel.text = "Referees, be careful! Read information by tapping on ℹ button"
        refereeWarningLabel.numberOfLines = 1
        refereeWarningLabel.font = UIFont(name: "Jellee-Roman", size: 10)
        refereeWarningLabel.textColor = Constants.secondColor?.withAlphaComponent(0.3)
        
        view.addSubview(refereeWarningLabel)
        refereeWarningLabel.pinLeft(to: view.leadingAnchor, 10)
        refereeWarningLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
    }
    
    private func configureFirstTeamLabel() {
        firstTeamLabel.text = "Select Team 1"
        firstTeamLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        firstTeamLabel.textColor = Constants.accentColor
        
        view.addSubview(firstTeamLabel)
        firstTeamLabel.pinTop(to: refereeWarningLabel.bottomAnchor, 3)
        firstTeamLabel.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureFirstTeamTextFieldPickerView() {
        firstTeamTextFieldPickerView.setPlaceholder(with: "Team 1")
        firstTeamTextFieldPickerView.setBackgroundColor(with: (Constants.secondColor?.withAlphaComponent(0.08))!)
        
        view.addSubview(firstTeamTextFieldPickerView)
        firstTeamTextFieldPickerView.pinTop(to: firstTeamLabel.bottomAnchor, 5)
        firstTeamTextFieldPickerView.pinHorizontal(to: view, 10)
        firstTeamTextFieldPickerView.setHeight(50)
    }
    
    private func configureSecondTeamLabel() {
        secondTeamLabel.text = "Select Team 2"
        secondTeamLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        secondTeamLabel.textColor = Constants.accentColor
        
        view.addSubview(secondTeamLabel)
        secondTeamLabel.pinTop(to: firstTeamTextFieldPickerView.bottomAnchor, 25)
        secondTeamLabel.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureSecondTeamTextFieldPickerView() {
        secondTeamTextFieldPickerView.setPlaceholder(with: "Team 2")
        secondTeamTextFieldPickerView.setBackgroundColor(with: (Constants.secondColor?.withAlphaComponent(0.08))!)
        
        view.addSubview(secondTeamTextFieldPickerView)
        secondTeamTextFieldPickerView.pinTop(to: secondTeamLabel.bottomAnchor, 5)
        secondTeamTextFieldPickerView.pinHorizontal(to: view, 10)
        secondTeamTextFieldPickerView.setHeight(50)
    }
    
    private func configureTablesWarningLabel() {
        tablesWarningLabel.text = "Swipe tables to add more informtaion"
        tablesWarningLabel.numberOfLines = 1
        tablesWarningLabel.font = UIFont(name: "Jellee-Roman", size: 10)
        tablesWarningLabel.textColor = Constants.secondColor?.withAlphaComponent(0.3)
        
        view.addSubview(tablesWarningLabel)
        tablesWarningLabel.pinLeft(to: view.leadingAnchor, 10)
        tablesWarningLabel.pinTop(to: secondTeamTextFieldPickerView.bottomAnchor, 30)
    }
    
    private func configureGoalsLabel() {
        goalsLabel.text = "Goals"
        goalsLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        goalsLabel.textColor = Constants.accentColor
        
        view.addSubview(goalsLabel)
        goalsLabel.pinTop(to: tablesWarningLabel.bottomAnchor, 3)
        goalsLabel.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureCardsLabel() {
        cardsLabel.text = "Cards"
        cardsLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        cardsLabel.textColor = Constants.accentColor
        
        view.addSubview(cardsLabel)
        cardsLabel.pinTop(to: goalsTableView.bottomAnchor, 25)
        cardsLabel.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureGoalsTableView() {
        view.addSubview(goalsTableView)
        goalsTableView.pinTop(to: goalsLabel.bottomAnchor, 5)
        goalsTableView.pinHorizontal(to: view, 10)
    }
    
    private func configureCardsTableView() {
        view.addSubview(cardsTableView)
        cardsTableView.pinTop(to: cardsLabel.bottomAnchor, 5)
        cardsTableView.pinHorizontal(to: view, 10)
    }
    
    private func configureContinueButton() {
        continueButton.layer.cornerRadius = 30
        continueButton.backgroundColor = Constants.accentColor
        
        let largeFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "sportscourt.fill", withConfiguration: configuration)
        continueButton.setImage(image, for: .normal)
        continueButton.tintColor = Constants.backgroundColor
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.pinBottom(to: view.bottomAnchor, 30)
        continueButton.pinCenterX(to: view.centerXAnchor)
        continueButton.setHeight(60)
        continueButton.setWidth(200)
    }
}

// MARK: - Fetching Data for MatchViewController
extension MatchViewController {
    private func fetchDataForTeam1PickerView() {
        firstTeamTextFieldPickerView.configureData(with: [
            "FC Bususiky",
            "Kuban' Peski",
            "Memphis",
            "CSAK",
            "FC Mentality",
            "FC Nika",
            "FC Alligators",
            "Vse Prosto",
            "Golden Boys",
            "FC Zvezda",
            "Na Laki",
            "CEM UNITED",
            "KFC",
        ])
    }
    
    private func fetchDataForTeam2PickerView() {
        secondTeamTextFieldPickerView.configureData(with: [
            "FC Bususiky",
            "Kuban' Peski",
            "Memphis",
            "CSAK",
            "FC Mentality",
            "FC Nika",
            "FC Alligators",
            "Vse Prosto",
            "Golden Boys",
            "FC Zvezda",
            "Na Laki",
            "CEM UNITED",
            "KFC",
        ])
    }
}
