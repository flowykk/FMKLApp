//
//  RefereeView.swift 
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class RefereeView: UIView {
    private let leftView: UIView = UIView()
    private let goButton: UIButton! = UIButton()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftView.roundCorners(topLeft: 15, topRight: 5, bottomRight: 5, bottomLeft: 15)
        goButton.roundCorners(topLeft: 5, topRight: 15, bottomRight: 15, bottomLeft: 5)
    }
}

extension RefereeView {
    @objc
    private func goButtonTapped() {
        
    }
}

extension RefereeView {
    private func configureUI() {
        setWidth(UIScreen.main.bounds.width)
        isUserInteractionEnabled = true
        configureLeftView()
        configureGoButton()
    }
    
    private func configureLeftView() {
        leftView.backgroundColor = Constants.secondColor?.withAlphaComponent(0.2)
        
        addSubview(leftView)
        leftView.setWidth(UIScreen.main.bounds.width * 0.65)
        leftView.setHeight(50)
        leftView.pinTop(to: topAnchor)
        leftView.pinLeft(to: leadingAnchor, 10)
    }
    
    private func configureGoButton() {
        goButton.backgroundColor = Constants.accentColor
        
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        
        addSubview(goButton)
        goButton.setHeight(50)
        goButton.pinTop(to: topAnchor)
        goButton.pinLeft(to: leftView.trailingAnchor, 10)
        goButton.pinRight(to: trailingAnchor, 10)
    }
}
