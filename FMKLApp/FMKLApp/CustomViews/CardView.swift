//
//  CardView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 13.06.2024.
//

import UIKit

class CardView: UIView {

    private let card: UIView = UIView()
    private let cardCount: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(isRed: Bool, count: Int) {
        card.backgroundColor = isRed ? Constants.redCardColor : Constants.yellowCardColor
        card.layer.borderColor = Constants.secondColor?.cgColor
        cardCount.text = String(count)
        cardCount.textColor = Constants.secondColor
        
        let titleSize = cardCount.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        setWidth(20 + titleSize.width + 5)
    }
}

extension CardView {
    private func configureUI() {
        configureCard()
        configureCount()
        
        //configureView()
    }
    
    private func configureCard() {
        card.layer.cornerRadius = 5
        
        self.addSubview(card)
        card.pinLeft(to: self, 0)
        card.setWidth(20)
        card.setHeight(30)
        card.pinCenterY(to: self)
    }
    
    private func configureCount() {
        cardCount.font = UIFont(name: "Jellee-Roman", size: 17)
        
        self.addSubview(cardCount)
        cardCount.pinLeft(to: card.trailingAnchor, 5)
        cardCount.pinCenterY(to: self)
    }
}
