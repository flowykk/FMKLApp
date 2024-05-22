//
//  imageLabelVie.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class ImageLabelView: UIView {
    private let label: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
    var imageName: String = String()
    var labelText: String = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName: String, labelText: String) {
        super.init(frame: .zero)
        
        self.imageName = imageName
        self.labelText = labelText
        
        configureUI()
    }
}

extension ImageLabelView {
    private func configureUI() {
        configureImage()
        configureLabel()
        configureView()
    }
    
    // MARK: - configuring Location Arrow Image
    private func configureImage() {
        imageView.image = UIImage(named: imageName)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let size: CGFloat = 20
        imageView.layer.cornerRadius = size / 2
        
        addSubview(imageView)
        imageView.pinLeft(to: leadingAnchor, 5)
        imageView.setWidth(size)
        imageView.setHeight(size)
        imageView.pinCenterY(to: centerYAnchor)
    }
    
    // MARK: - configuring Location Label
    private func configureLabel() {
        label.text = labelText
        label.font = UIFont(name: "Jellee-Roman", size: 17)
        label.textColor = Constants.accentColor
        
        addSubview(label)
        label.pinLeft(to: imageView.trailingAnchor, 5)
        label.pinCenterY(to: centerYAnchor)
    }
    
    private func configureView() {
        let imageSize = imageView.image?.size
        let titleSize = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        setWidth(5 + 5 + titleSize.width + imageSize!.width + 5)
    }
}
