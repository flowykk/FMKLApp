//
//  CustomTableViewCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    private let iconBackgroundView: UIView = UIView()
    private let iconImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    private let chevronImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset = UIEdgeInsets(top: 0, left: nameLabel.frame.origin.x, bottom: 0, right: 0)
    }
}

extension CustomTableViewCell {
    func configure(withName name: String, imageName: String) {
        backgroundColor = Constants.secondColor?.withAlphaComponent(0.1)
        nameLabel.text = name
        iconImageView.image = UIImage(systemName: imageName)
        iconImageView.tintColor = Constants.secondColor
        nameLabel.textColor = Constants.secondColor
        nameLabel.font = UIFont(name: "Jellee-Roman", size: 15)
        chevronImageView.tintColor = Constants.secondColor
        iconBackgroundView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.1)
    }
}

// MARK: - UI Configuration
extension CustomTableViewCell {
    private func configureUI() {
        backgroundColor = .systemGray6
        configureIconBackgroundView()
        configureIconImageView()
        configureNameLabel()
        configureChevronImageView()
    }
    
    private func configureIconBackgroundView() {
        addSubview(iconBackgroundView)
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        iconBackgroundView.layer.cornerRadius = 10
        
        iconBackgroundView.pinLeft(to: leadingAnchor, 12)
        iconBackgroundView.pinCenterY(to: centerYAnchor)
        iconBackgroundView.setHeight(30)
        iconBackgroundView.setWidth(30)
    }
    
    private func configureIconImageView() {
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.contentMode = .scaleAspectFit
        
        iconImageView.pinCenter(to: iconBackgroundView)
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        nameLabel.pinLeft(to: iconBackgroundView.trailingAnchor, 12)
        nameLabel.pinCenterY(to: iconBackgroundView.centerYAnchor)
    }
    
    private func configureChevronImageView() {
        chevronImageView.contentMode = .scaleAspectFit
        let largeFont = UIFont.systemFont(ofSize: 16, weight: .black)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        chevronImageView.image = image
        
        addSubview(chevronImageView)
        chevronImageView.pinRight(to: trailingAnchor, 18)
        chevronImageView.pinCenterY(to: centerYAnchor)
    }
}
