//
//  PreviewAvatarViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 22.05.2024.
//

import UIKit

final class PreviewAvatarViewController: UIViewController {
    var presenter: PreviewAvatarPresenter?
    var avatarImage: UIImage!
    
    private let avatarImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        configureUI()
    }
}

// MARK: - Class functions
extension PreviewAvatarViewController {
    @objc
    private func handleTapOutsideImage(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !avatarImageView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UI Configuration
extension PreviewAvatarViewController {
    private func configureUI() {
        configureTapGesture()
        configureBlurEffect()
        
        configureAvatarImageView()
    }
    
    private func configureAvatarImageView() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = avatarImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        
        let size = view.frame.width / 2 + 50
        avatarImageView.layer.cornerRadius = size / 2
        
        view.addSubview(avatarImageView)
        avatarImageView.setWidth(size)
        avatarImageView.setHeight(size)
        avatarImageView.pinCenter(to: view)
    }
    
    private func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
    }
}

// MARK: - Gestures Configuration
extension PreviewAvatarViewController {
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideImage))
        view.addGestureRecognizer(tapGesture)
    }
}
