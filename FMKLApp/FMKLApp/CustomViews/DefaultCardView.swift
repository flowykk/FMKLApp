//
//  DefaultCardView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

class DefaultCardView: UIView {

    private let card: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(isRed: Bool) {
        card.backgroundColor = isRed ? Constants.redCardColor : Constants.yellowCardColor
        card.layer.borderColor = Constants.secondColor?.cgColor
    }
}

extension DefaultCardView {
    private func configureUI() {
        configureCard()
    }
    
    private func configureCard() {
        card.layer.cornerRadius = 5
        
        self.addSubview(card)
        card.pinCenterX(to: self)
        card.setWidth(20)
        card.setHeight(30)
        card.pinCenterY(to: self)
    }
}

