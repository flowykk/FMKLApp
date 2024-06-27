//
//  SocialMediaButton.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.06.2024.
//

import UIKit

final class SocialMediaButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)

        configureUI()
    }
}

// MARK: - Class functions
extension SocialMediaButton {
    func set(text: String) {
        setTitle(text, for: .normal)
    }
}

// MARK: - UI Configuration
extension SocialMediaButton {
    private func configureUI() {
        setTitleColor(Constants.backgroundColor, for: .normal)
        titleLabel?.font = UIFont(name: "Jellee-Roman", size: 12)
        
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        setImage(image, for: .normal)
        
        tintColor = Constants.backgroundColor
        backgroundColor = Constants.accentColor
        layer.cornerRadius = 12
        
        semanticContentAttribute = .forceRightToLeft
        imageEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: -7)
        
        setHeight(30)
        setWidth(150)
    }
}
