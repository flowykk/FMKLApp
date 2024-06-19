//
//  MatchViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class MatchViewController: UIViewController, UITextFieldDelegate {
    var presenter: MatchPresenter?
    
    private let teams = ["FC Bususiky", "Memphis"]
    
    private let titleView: UILabel = UILabel()
    
    private let firstTeamLabel: UILabel = UILabel()
    private let firstTeamTextFieldPickerView: TextFieldPickerView = TextFieldPickerView()
    
    private let secondTeamLabel: UILabel = UILabel()
    private let secondTeamTextFieldPickerView: TextFieldPickerView = TextFieldPickerView()
    
    private let goalsLabel: UILabel = UILabel()
    private let goalsTableView: GoalsTableView = GoalsTableView()
    
    private let cardsLabel: UILabel = UILabel()
    private let cardsTableView: AddCardTableView = AddCardTableView()
    
    private let continueButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        configureUI()
    }
    
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

extension MatchViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureBackButton()
        configureInfoButton()
        
        configureFirstTeamLabel()
        configureFirstTeamTextFieldPickerView()
        
        configureSecondTeamLabel()
        configureSecondTeamTextFieldPickerView()
        
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
    
    private func configureFirstTeamLabel() {
        firstTeamLabel.text = "Select Team 1"
        firstTeamLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        firstTeamLabel.textColor = Constants.accentColor
        
        view.addSubview(firstTeamLabel)
        firstTeamLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        firstTeamLabel.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configureFirstTeamTextFieldPickerView() {
        view.addSubview(firstTeamTextFieldPickerView)
        firstTeamTextFieldPickerView.pinTop(to: firstTeamLabel.bottomAnchor, 5)
        firstTeamTextFieldPickerView.pinHorizontal(to: view)
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
        view.addSubview(secondTeamTextFieldPickerView)
        secondTeamTextFieldPickerView.pinTop(to: secondTeamLabel.bottomAnchor, 5)
        secondTeamTextFieldPickerView.pinHorizontal(to: view)
        secondTeamTextFieldPickerView.setHeight(50)
    }
    
    private func configureGoalsLabel() {
        goalsLabel.text = "Goals"
        goalsLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        goalsLabel.textColor = Constants.accentColor
        
        view.addSubview(goalsLabel)
        goalsLabel.pinTop(to: secondTeamTextFieldPickerView.bottomAnchor, 25)
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
