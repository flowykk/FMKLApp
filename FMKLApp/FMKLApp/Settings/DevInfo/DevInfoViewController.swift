//
//  DevInfoViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class DevInfoViewController: UIViewController { 
    var presenter: DevInfoPresenter?

    var viewDistanceTop: CGFloat = 300
    
    private let appInfoLabel: UILabel = UILabel()
    
    private let instButton: SocialMediaButton = SocialMediaButton()
    private let tgButton: SocialMediaButton = SocialMediaButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.frame.size.height = viewDistanceTop
        view.frame.origin.y = UIScreen.main.bounds.height - viewDistanceTop
        view.layer.cornerRadius = 40
    }
}

// MARK: - Class functions
extension DevInfoViewController {
    @objc
    private func instButtonTapped() {
        presenter?.instButtonTapped()
    }
    
    @objc
    private func tgButtonTapped() {
        presenter?.tgButtonTapped()
    }
}

// MARK: - UI Configuration
extension DevInfoViewController {
    private func configureUI() {
        view.backgroundColor = Constants.popupColor
        
        configureAppInfoLabel()
        configureInstButton()
        configureTgButton()
    }
    
    private func configureAppInfoLabel() {
        appInfoLabel.numberOfLines = 2
        appInfoLabel.text = """
        Mobile App for Football Media Kolomna League
        Developed by flowykk
        """
        appInfoLabel.font = UIFont(name: "Jellee-Roman", size: 12)
        appInfoLabel.textColor = Constants.popupTextColor
        appInfoLabel.textAlignment = .center
        
        appInfoLabel.halfTextColorChange(fullText: appInfoLabel.text!, changeText: "flowykk")
        
        view.addSubview(appInfoLabel)
        appInfoLabel.pinTop(to: view.topAnchor, 15)
        appInfoLabel.pinCenterX(to: view.centerXAnchor)
        appInfoLabel.pinHorizontal(to: view, 15)
    }
    
    private func configureInstButton() {
        instButton.set(text: "inst: flowykk")
        instButton.addTarget(self, action: #selector(instButtonTapped), for: .touchUpInside)
        
        view.addSubview(instButton)
        instButton.pinTop(to: appInfoLabel.bottomAnchor, 25)
        instButton.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureTgButton() {
        tgButton.set(text: "telegram: flowykk")
        tgButton.addTarget(self, action: #selector(tgButtonTapped), for: .touchUpInside)
        
        view.addSubview(tgButton)
        tgButton.pinTop(to: instButton.bottomAnchor, 5)
        tgButton.pinCenterX(to: view.centerXAnchor)
    }
}

// MARK: - Gestures Configuration
extension DevInfoViewController {
    @objc
    private func handleTapGesture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !instButton.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            let translation = gesture.translation(in: view)
            if view.frame.origin.y + translation.y >= UIScreen.main.bounds.height - viewDistanceTop {
                view.frame.origin.y += translation.y
                gesture.setTranslation(.zero, in: view)
            }
        case .ended:
            let velocity = gesture.velocity(in: view)
            let childViewHeight = viewDistanceTop
            if velocity.y > 0 && view.frame.origin.y > childViewHeight * 0.5 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame.origin.y = UIScreen.main.bounds.height
                }) { _ in
                    self.dismiss(animated: false, completion: nil)
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame.origin.y = UIScreen.main.bounds.height - self.viewDistanceTop
                }) { _ in
                    self.view.frame.origin.y = UIScreen.main.bounds.height - self.viewDistanceTop
                }
            }
        default:
            break
        }
    }
}
