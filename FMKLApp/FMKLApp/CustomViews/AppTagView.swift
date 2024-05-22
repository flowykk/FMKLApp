//
//  AppTagView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class AppTagView: UIView {
    private let appLabel: UILabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        gradientLayer.colors = [UIColor.systemCyan.cgColor, UIColor.systemRed.cgColor]
        //layer.addSublayer(gradientLayer)
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
}

extension AppTagView {
    private func configureUI() {
        setWidth(65)
        setHeight(21)
        
        configureAppLabel()
    }
    
    private func configureAppLabel() {
        appLabel.text = "FMKL"
        appLabel.font = UIFont(name: "Jellee-Roman", size: 12)
        appLabel.textColor = Constants.backgroundColor
        
        addSubview(appLabel)
        appLabel.pinCenter(to: self)
    }
}
