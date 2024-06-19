//
//  AddCell.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

final class AddCell: UITableViewCell {
    private let addButton: UIButton = UIButton()
    
    var addButtonTapAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func addButtonTapped() {
        addButtonTapAction?()
    }
}

extension AddCell {
    private func configureUI() {
        configureButtonLabel()
    }
    
    private func configureButtonLabel() {
        addButton.backgroundColor = Constants.accentColor
        addButton.layer.cornerRadius = 15
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let largeFont = UIFont.systemFont(ofSize: 20, weight: .black)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: configuration)
        addButton.setImage(image, for: .normal)
        addButton.tintColor = .white
        
        contentView.addSubview(addButton)
        addButton.pinLeft(to: leadingAnchor, 0)
        addButton.pinRight(to: trailingAnchor, 0)
        addButton.pinVertical(to: self, 2)
    }
}
