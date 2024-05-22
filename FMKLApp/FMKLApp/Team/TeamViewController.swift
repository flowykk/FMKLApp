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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
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
        
        //configureImageView()
    }
    
    private func configureTitleView() {
        let userImageView = UIImageView()
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 15
        userImageView.image = UIImage(named: shortTeamName!)
        
        let imageSize: Double = 32.0
        
        titleView.addSubview(userImageView)
        userImageView.setWidth(imageSize)
        userImageView.setHeight(imageSize)
        userImageView.pinTop(to: titleView)
        userImageView.pinCenterY(to: titleView.centerYAnchor)
        
        let usernameLabel = UILabel()
        usernameLabel.text = fullTeamName
        usernameLabel.textColor = Constants.accentColor
        usernameLabel.sizeToFit()
        usernameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        titleView.addSubview(usernameLabel)
        usernameLabel.pinTop(to: titleView)
        usernameLabel.pinLeft(to: userImageView.trailingAnchor, 7)
        usernameLabel.pinCenterY(to: titleView.centerYAnchor)
                
        let width = imageSize + 7.0 + usernameLabel.frame.width
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
