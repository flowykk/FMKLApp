//
//  DevInfoViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class DevInfoViewController: UIViewController {    
    var viewDistanceTop: CGFloat = 300
    
    private let appInfoLabel: UILabel = UILabel()
    private let instLabel: UILabel = UILabel()
    private let telegramLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideImage))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.frame.size.height = viewDistanceTop
        view.frame.origin.y = UIScreen.main.bounds.height - viewDistanceTop
        view.layer.cornerRadius = 30
    }
}

// MARK: - UI Configuration
extension DevInfoViewController {
    private func configureUI() {
        view.backgroundColor = Constants.popupColor
        
        configureAppInfoLabel()
        configureInstLabel()
        configureTelegramLabel()
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
    
    private func configureInstLabel() {
        instLabel.text = "inst: flowykk"
        instLabel.font = UIFont(name: "Jellee-Roman", size: 12)
        instLabel.textColor = Constants.popupTextColor
        instLabel.textAlignment = .center
        
        instLabel.halfTextColorChange(fullText: instLabel.text!, changeText: "flowykk")
        
        view.addSubview(instLabel)
        instLabel.pinTop(to: appInfoLabel.bottomAnchor, 20)
        instLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureTelegramLabel() {
        telegramLabel.text = "telegram: flowykk"
        telegramLabel.font = UIFont(name: "Jellee-Roman", size: 12)
        telegramLabel.textColor = Constants.popupTextColor
        telegramLabel.textAlignment = .center
        
        telegramLabel.halfTextColorChange(fullText: telegramLabel.text!, changeText: "flowykk")
        
        view.addSubview(telegramLabel)
        telegramLabel.pinTop(to: instLabel.bottomAnchor, 3)
        telegramLabel.pinCenterX(to: view.centerXAnchor)
    }
}

// MARK: - Private funcs
extension DevInfoViewController {
    @objc
    private func handleTapOutsideImage(sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
