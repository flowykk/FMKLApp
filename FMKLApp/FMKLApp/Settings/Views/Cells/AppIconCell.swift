//
//  AppIconCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class AppIconCell: UICollectionViewCell {
    private let appIconView: UIImageView = UIImageView()
    static var initialSelectedIcon: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppIconCell {
    func configure(withImage name: String) {
        appIconView.image = UIImage(named: name)
        if AppIconCell.initialSelectedIcon == name {
            makeSelected()
        }
    }
    
    func makeSelected() {
        layer.borderColor = Constants.accentColor?.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 15
    }
    
    func makeUnselected() {
        layer.borderWidth = 0
    }
}

// MARK: - UI Configuration
extension AppIconCell {
    private func configureUI() {
        configureAppIconView()
    }
    
    private func configureAppIconView() {
        addSubview(appIconView)
        appIconView.translatesAutoresizingMaskIntoConstraints = false
        
        appIconView.contentMode = .scaleAspectFill
        appIconView.clipsToBounds = true
        appIconView.layer.cornerRadius = 15
        
        appIconView.pinCenter(to: self)
        appIconView.setWidth(70)
        appIconView.setHeight(70)
    }
}
