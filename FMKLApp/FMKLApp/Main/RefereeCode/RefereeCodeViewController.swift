//
//  RefereeCodeViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.05.2024.
//

import UIKit

final class RefereeCodeViewController: UIViewController, UITextFieldDelegate {
    var presenter: RefereeCodePresenter?

    var viewDistanceTop: CGFloat = 40
    
    private let refereeCodeLabel: UILabel = UILabel()
    
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
        view.frame.size.height = UIScreen.main.bounds.height - viewDistanceTop
        view.frame.origin.y = viewDistanceTop
        view.layer.cornerRadius = 30
    }
}

// MARK: - UI Configuration
extension RefereeCodeViewController {
    private func configureUI() {
        view.backgroundColor = Constants.popupColor
        
        configureRefereeCodeLabel()
    }
    
    private func configureRefereeCodeLabel() {
        refereeCodeLabel.text = "Enter referee code"
        refereeCodeLabel.font = UIFont(name: "Jellee-Roman", size: 18)
        refereeCodeLabel.textColor = Constants.secondColor

        
        view.addSubview(refereeCodeLabel)
        refereeCodeLabel.pinTop(to: view.topAnchor, 200)
        refereeCodeLabel.pinCenterX(to: view.centerXAnchor)
    }
}

// MARK: - Private funcs
extension RefereeCodeViewController {
    @objc
    private func handleTapGesture(sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            let translation = gesture.translation(in: view)
            if view.frame.origin.y + translation.y >= viewDistanceTop {
                view.frame.origin.y += translation.y
                gesture.setTranslation(.zero, in: view)
            }
        case .ended:
            let velocity = gesture.velocity(in: view)
            let childViewHeight = UIScreen.main.bounds.height - viewDistanceTop
            if velocity.y > 0 && view.frame.origin.y > childViewHeight * 0.5 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame.origin.y = UIScreen.main.bounds.height
                }) { _ in
                    self.dismiss(animated: false, completion: nil)
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame.origin.y = self.viewDistanceTop
                }) { _ in
                    self.view.frame.origin.y = self.viewDistanceTop
                }
            }
        default:
            break
        }
    }
}
