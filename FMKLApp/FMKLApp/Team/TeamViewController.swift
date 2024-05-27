//
//  TeamViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.05.2024.
//

import UIKit

final class TeamViewController: UIViewController {
    var presenter: TeamPresenter?
    
    var fullTeamName: String?
    var shortTeamName: String?
    
    private var titleView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    
    private let playersLabel: UILabel = UILabel()
    private let playersTableView: TeamPlayersTableView = TeamPlayersTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        playersTableView.presenter = presenter
        
        configureUI()
        configureTapGesture()
    }
    
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc func navigationBarTapped(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: self.navigationController?.navigationBar)
        let hitView = self.navigationController?.navigationBar.hitTest(location, with: nil)

        guard !(hitView is UIControl) else { return }

        presenter?.goToAvatarPreview(with: UIImage(named: shortTeamName!)!)
    }
}

extension TeamViewController {
    func configureTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.navigationBarTapped(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension TeamViewController {
    private func configureUI() {
        configureTitleView()
        configureNavigationBar()
        configureBackButton()
        
        configurePlayersLabel()
        configurePlayersTableView()
        //configureImageView()
    }
    
    private func configureTitleView() {
        let teamimageView = UIImageView()
        teamimageView.contentMode = .scaleAspectFill
        teamimageView.clipsToBounds = true
        teamimageView.layer.cornerRadius = 15
        teamimageView.image = UIImage(named: shortTeamName!)
        
        let imageSize: Double = 30.0
        
        titleView.addSubview(teamimageView)
        teamimageView.setWidth(imageSize)
        teamimageView.setHeight(imageSize)
        teamimageView.pinTop(to: titleView)
        teamimageView.pinCenterY(to: titleView.centerYAnchor)
        
        let teamNameLabel = UILabel()
        teamNameLabel.text = fullTeamName
        teamNameLabel.textColor = Constants.accentColor
        teamNameLabel.sizeToFit()
        teamNameLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        
        titleView.addSubview(teamNameLabel)
        teamNameLabel.pinTop(to: titleView)
        teamNameLabel.pinLeft(to: teamimageView.trailingAnchor, 5)
        teamNameLabel.pinCenterY(to: titleView.centerYAnchor)
                
        let width = imageSize + 5.0 + teamNameLabel.bounds.width
        titleView.setWidth(width)
        titleView.setHeight(imageSize)
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
    
    private func configurePlayersLabel() {
        playersLabel.text = "Players"
        playersLabel.font = UIFont(name: "Jellee-Roman", size: 16)
        playersLabel.textColor = Constants.accentColor
        
        view.addSubview(playersLabel)
        playersLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        playersLabel.pinLeft(to: view.leadingAnchor, 10)
    }
    
    private func configurePlayersTableView() {
        view.addSubview(playersTableView)
        playersTableView.pinTop(to: playersLabel.bottomAnchor, 5)
        playersTableView.pinHorizontal(to: view, 10)
    }
    
    private func configureImageView() {
        imageView.image = UIImage(named: shortTeamName!)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let size = UIScreen.main.bounds.width * 0.4
        imageView.layer.cornerRadius = size / 2
        
        view.addSubview(imageView)
        imageView.pinLeft(to: view.leadingAnchor, 20)
        imageView.setWidth(size)
        imageView.setHeight(size)
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
    }
}
