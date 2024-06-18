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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        configureUI()
    }
    
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
}

extension MatchViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureBackButton()
        
        configureFirstTeamLabel()
        configureFirstTeamTextFieldPickerView()
        
        configureSecondTeamLabel()
        configureSecondTeamTextFieldPickerView()
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
}
