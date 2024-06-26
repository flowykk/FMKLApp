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
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    private var titleView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    
    private let playersLabel: UILabel = UILabel()
    private let playersTableView: TeamPlayersTableView = TeamPlayersTableView()
    
    private let playersCardsLabel: UILabel = UILabel()
    private let playersCardsTableView: PlayersCardsTableView = PlayersCardsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        playersTableView.presenter = presenter
        
        configureUI()
        configureTapGesture()
    }
}

// MARK: - Class functions
extension TeamViewController {
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc
    private func navigationBarTapped(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: self.navigationController?.navigationBar)
        let hitView = self.navigationController?.navigationBar.hitTest(location, with: nil)

        guard !(hitView is UIControl) else { return }

        presenter?.goToAvatarPreview(with: UIImage(named: shortTeamName!)!)
    }
    
    private func configureTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.navigationBarTapped(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - UI Configuration
extension TeamViewController {
    private func configureUI() {
        configureScrollView()
        configureContentView()
        
        configureTitleView()
        configureNavigationBar()
        configureBackButton()
        
        configurePlayersLabel()
        configurePlayersTableView()
        
        configurePlayersCardsLabel()
        configurePlayersCardsTableView()
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
                
        let teamNameSize = teamNameLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        let width = imageSize + 5.0 + teamNameSize.width
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
        playersLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        playersLabel.textColor = Constants.accentColor
        
        contentView.addSubview(playersLabel)
        playersLabel.pinTop(to: contentView.safeAreaLayoutGuide.topAnchor, 15)
        playersLabel.pinLeft(to: contentView.leadingAnchor, 10)
    }
    
    private func configurePlayersTableView() {
        contentView.addSubview(playersTableView)
        playersTableView.pinTop(to: playersLabel.bottomAnchor, 5)
        playersTableView.pinHorizontal(to: contentView, 10)
    }
    
    private func configurePlayersCardsLabel() {
        playersCardsLabel.text = "Players' Cards"
        playersCardsLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        playersCardsLabel.textColor = Constants.accentColor
        
        contentView.addSubview(playersCardsLabel)
        playersCardsLabel.pinTop(to: playersTableView.bottomAnchor, 20)
        playersCardsLabel.pinLeft(to: contentView.leadingAnchor, 10)
    }
    
    private func configurePlayersCardsTableView() {
        contentView.addSubview(playersCardsTableView)
        playersCardsTableView.pinTop(to: playersCardsLabel.bottomAnchor, 5)
        playersCardsTableView.pinHorizontal(to: contentView, 10)
    }
    
    private func configureImageView() {
        imageView.image = UIImage(named: shortTeamName!)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let size = UIScreen.main.bounds.width * 0.4
        imageView.layer.cornerRadius = size / 2
        
        contentView.addSubview(imageView)
        imageView.pinLeft(to: contentView.leadingAnchor, 20)
        imageView.setWidth(size)
        imageView.setHeight(size)
        imageView.pinTop(to: contentView.safeAreaLayoutGuide.topAnchor, 20)
    }
}
