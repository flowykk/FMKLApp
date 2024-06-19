//
//  RefereeCodeViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.05.2024.
//

import UIKit

final class RefereeCodeViewController: UIViewController {
    var presenter: RefereeCodePresenter?
    var mainVC: MainViewController?
    var viewDistanceTop: CGFloat = 40
    
    private let refereeCodeLabel: UILabel = UILabel()
    private let refereeCodeField: UITextField = UITextField()
    private let refereeWarningLabel: UILabel = UILabel()
    private let continueButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    
        configureUI()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func continueButtonTapped() {
        presenter?.continuteButtonTapped(code: refereeCodeField.text ?? "")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.frame.size.height = UIScreen.main.bounds.height - viewDistanceTop
        view.frame.origin.y = viewDistanceTop
        view.layer.cornerRadius = 40
    }
}

extension RefereeCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        continueButtonTapped()
        return false
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustButtonForKeyboard(notification: notification, show: true)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        adjustButtonForKeyboard(notification: notification, show: false)
    }
    
    func adjustButtonForKeyboard(notification: Notification, show: Bool) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.continueButton.transform = show ? CGAffineTransform(translationX: 0, y: -keyboardHeight) : .identity
        }
    }
}

// MARK: - UI Configuration
extension RefereeCodeViewController {
    private func configureUI() {
        view.backgroundColor = Constants.popupColor
        
        configureRefereeCodeLabel()
        configureNameField()
        configureRefereeWarningLabel()
        configureContinueButton()
    }
    
    private func configureRefereeCodeLabel() {
        refereeCodeLabel.text = "Enter referee code"
        refereeCodeLabel.font = UIFont(name: "Jellee-Roman", size: 20)
        refereeCodeLabel.textColor = Constants.secondColor

        refereeCodeLabel.halfTextColorChange(fullText: refereeCodeLabel.text!, changeText: "referee")
        
        view.addSubview(refereeCodeLabel)
        refereeCodeLabel.pinTop(to: view.topAnchor, 180)
        refereeCodeLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureNameField() {
        refereeCodeField.delegate = self
        
        refereeCodeField.backgroundColor = Constants.backgroundColor
        refereeCodeField.placeholder = "Code"
        refereeCodeField.font = UIFont(name: "Jellee-Roman", size: 18)
        refereeCodeField.textColor = Constants.secondColor
        refereeCodeField.layer.cornerRadius = 15
        refereeCodeField.returnKeyType = .done
        
        refereeCodeField.autocapitalizationType = .none
        refereeCodeField.autocorrectionType = .no
        
        refereeCodeField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        refereeCodeField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        refereeCodeField.leftViewMode = .always
        refereeCodeField.rightViewMode = .always
        
        view.addSubview(refereeCodeField)
        refereeCodeField.setWidth(350)
        refereeCodeField.setHeight(50)
        refereeCodeField.pinTop(to: refereeCodeLabel.bottomAnchor, 10)
        refereeCodeField.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureRefereeWarningLabel() {
        refereeWarningLabel.text = "Ask league admins for the code "
        refereeWarningLabel.font = UIFont(name: "Jellee-Roman", size: 12)
        refereeWarningLabel.textColor = Constants.popupTextColor
        
        view.addSubview(refereeWarningLabel)
        refereeWarningLabel.pinTop(to: refereeCodeField.bottomAnchor, 10)
        refereeWarningLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(Constants.backgroundColor, for: .normal)
        continueButton.titleLabel?.font = UIFont(name: "Jellee-Roman", size: 20)
        continueButton.layer.cornerRadius = 30
        continueButton.backgroundColor = Constants.accentColor
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.pinBottom(to: view.bottomAnchor, 30)
        continueButton.pinCenterX(to: view.centerXAnchor)
        continueButton.setHeight(60)
        continueButton.setWidth(200)
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
            if velocity.y > 0 && view.frame.origin.y > childViewHeight * 0.2 {
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
