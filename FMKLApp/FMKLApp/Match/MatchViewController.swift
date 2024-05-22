//
//  MatchViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class MatchViewController: UIViewController {
    var presenter: MatchPresenter?
    
    private let titleView: UILabel = UILabel()
    
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
}
