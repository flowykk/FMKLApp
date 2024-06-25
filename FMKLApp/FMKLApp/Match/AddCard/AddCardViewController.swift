//
//  AddCardViewController.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 25.06.2024.
//

import UIKit

final class AddCardViewController: UIViewController {
    var presenter: AddCardPresenter?
    var matchVC: MatchViewController?
    var viewDistanceTop: CGFloat = 40
    
    private var isRedCardSelected = false
    
    private let teamLabel: UILabel = UILabel()
    private let teamTextFieldPickerView: TextFieldPickerView = TextFieldPickerView()
    
    private let scoredPlayerLabel: UILabel = UILabel()
    private let scoredPlayerTextFieldPickerView: TextFieldPickerView = TextFieldPickerView()
    
    private let minuteLabel: UILabel = UILabel()
    private let minuteField: UITextField = UITextField()
    
    private let cardsLabel: UILabel = UILabel()
    private let yellowCardButton: UIButton = UIButton()
    private let redCardButton: UIButton = UIButton()
    
    private let continueButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    
        fetchDataForTeamPickerView()
        fetchDataForScoredPlayerPickerView()
        
        configureUI()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func continueButtonTapped() {
        presenter?.continuteButtonTapped(
            withCard: PlayerCard(
                team: teamTextFieldPickerView.getTextFieldData(),
                player: scoredPlayerTextFieldPickerView.getTextFieldData(),
                minute: Int(minuteField.text ?? "0") ?? -1,
                isCardRed: isRedCardSelected
            )
        )
    }
    
    @objc
    private func redCardButtonTapped() {
        guard !isRedCardSelected else { return }
        
        isRedCardSelected = true
        redCardButton.layer.borderWidth = 3
        yellowCardButton.layer.borderWidth = 0
    }
    
    @objc
    private func yellowCardButtonTapped() {
        guard isRedCardSelected else { return }
        
        isRedCardSelected = false
        redCardButton.layer.borderWidth = 0
        yellowCardButton.layer.borderWidth = 3
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.frame.size.height = UIScreen.main.bounds.height - viewDistanceTop
        view.frame.origin.y = viewDistanceTop
        view.layer.cornerRadius = 40
    }
}

extension AddCardViewController: UITextFieldDelegate {
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
extension AddCardViewController {
    private func configureUI() {
        view.backgroundColor = Constants.popupColor
        
        configureTeamLabel()
        configureTeamTextFieldPickerView()
        
        configureScoredPlayerLabel()
        configureScoredPlayerTextFieldPickerView()
        
        configureMinuteLabel()
        configureMinuteField()
        
        configureCardsLabel()
        configureYellowCardButton()
        configureRedCardButton()

        configureContinueButton()
    }
    
    private func configureTeamLabel() {
        teamLabel.text = "Select scored team"
        teamLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        teamLabel.textColor = Constants.secondColor

        teamLabel.halfTextColorChange(fullText: teamLabel.text!, changeText: "scored")
        
        view.addSubview(teamLabel)
        teamLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        teamLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureTeamTextFieldPickerView() {
        teamTextFieldPickerView.setPlaceholder(with: "Team")
        teamTextFieldPickerView.setBackgroundColor(with: Constants.backgroundColor!)
        
        view.addSubview(teamTextFieldPickerView)
        teamTextFieldPickerView.pinTop(to: teamLabel.bottomAnchor, 5)
        teamTextFieldPickerView.pinHorizontal(to: view, 20)
        teamTextFieldPickerView.setHeight(50)
    }
    
    private func configureScoredPlayerLabel() {
        scoredPlayerLabel.text = "Select scored player"
        scoredPlayerLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        scoredPlayerLabel.textColor = Constants.secondColor

        scoredPlayerLabel.halfTextColorChange(fullText: scoredPlayerLabel.text!, changeText: "scored")
        
        view.addSubview(scoredPlayerLabel)
        scoredPlayerLabel.pinTop(to: teamTextFieldPickerView.bottomAnchor, 15)
        scoredPlayerLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureScoredPlayerTextFieldPickerView() {
        scoredPlayerTextFieldPickerView.setPlaceholder(with: "Player P.")
        scoredPlayerTextFieldPickerView.setBackgroundColor(with: Constants.backgroundColor!)
        
        view.addSubview(scoredPlayerTextFieldPickerView)
        scoredPlayerTextFieldPickerView.pinTop(to: scoredPlayerLabel.bottomAnchor, 5)
        scoredPlayerTextFieldPickerView.pinHorizontal(to: view, 20)
        scoredPlayerTextFieldPickerView.setHeight(50)
    }
    
    private func configureMinuteLabel() {
        minuteLabel.text = "Enter match minute"
        minuteLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        minuteLabel.textColor = Constants.secondColor

        minuteLabel.halfTextColorChange(fullText: minuteLabel.text!, changeText: "minute")
        
        view.addSubview(minuteLabel)
        minuteLabel.pinTop(to: scoredPlayerTextFieldPickerView.bottomAnchor, 15)
        minuteLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureMinuteField() {
        minuteField.delegate = self
        
        minuteField.backgroundColor = Constants.backgroundColor
        minuteField.placeholder = "10"
        minuteField.font = UIFont(name: "Jellee-Roman", size: 18)
        minuteField.textColor = Constants.secondColor
        minuteField.layer.cornerRadius = 15
        minuteField.returnKeyType = .done
        
        minuteField.autocapitalizationType = .none
        minuteField.autocorrectionType = .no
        
        minuteField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        minuteField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        minuteField.leftViewMode = .always
        minuteField.rightViewMode = .always
        
        view.addSubview(minuteField)
        minuteField.pinHorizontal(to: view, 20)
        minuteField.setHeight(50)
        minuteField.pinTop(to: minuteLabel.bottomAnchor, 5)
        minuteField.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureCardsLabel() {
        cardsLabel.text = "Select card"
        cardsLabel.font = UIFont(name: "Jellee-Roman", size: 17)
        cardsLabel.textColor = Constants.secondColor

        cardsLabel.halfTextColorChange(fullText: cardsLabel.text!, changeText: "card")
        
        view.addSubview(cardsLabel)
        cardsLabel.pinTop(to: minuteField.bottomAnchor, 15)
        cardsLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureYellowCardButton() {
        yellowCardButton.backgroundColor = Constants.backgroundColor
        yellowCardButton.layer.cornerRadius = 15
        yellowCardButton.layer.borderColor = Constants.accentColor?.cgColor
        yellowCardButton.layer.borderWidth = 3

        yellowCardButton.addTarget(self, action: #selector(yellowCardButtonTapped), for: .touchUpInside)
        
        view.addSubview(yellowCardButton)
        yellowCardButton.setHeight(60)
        yellowCardButton.pinTop(to: cardsLabel.bottomAnchor, 5)
        yellowCardButton.pinLeft(to: view, 20)
        yellowCardButton.setWidth(UIScreen.main.bounds.width * 0.44)
        
        let card: DefaultCardView = DefaultCardView()
        card.set(isRed: false)
        
        yellowCardButton.addSubview(card)
        card.pinCenter(to: yellowCardButton)
        card.setWidth(30)
        card.setHeight(60)
    }
    
    private func configureRedCardButton() {
        redCardButton.backgroundColor = Constants.backgroundColor
        redCardButton.layer.cornerRadius = 15
        redCardButton.layer.borderColor = Constants.accentColor?.cgColor
        
        redCardButton.addTarget(self, action: #selector(redCardButtonTapped), for: .touchUpInside)
        
        view.addSubview(redCardButton)
        redCardButton.setHeight(60)
        redCardButton.pinTop(to: cardsLabel.bottomAnchor, 5)
        redCardButton.pinRight(to: view, 20)
        redCardButton.setWidth(UIScreen.main.bounds.width * 0.44)
        
        let card: DefaultCardView = DefaultCardView()
        card.set(isRed: true)
        
        redCardButton.addSubview(card)
        card.pinCenter(to: redCardButton)
        card.setWidth(30)
        card.setHeight(60)
    }
    
    private func configureContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(Constants.backgroundColor, for: .normal)
        continueButton.titleLabel?.font = UIFont(name: "Jellee-Roman", size: 20)
        continueButton.layer.cornerRadius = 30
        continueButton.backgroundColor = Constants.accentColor
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.pinBottom(to: view.bottomAnchor, 17)
        continueButton.pinCenterX(to: view.centerXAnchor)
        continueButton.setHeight(60)
        continueButton.setWidth(200)
    }
}

// MARK: - Private funcs
extension AddCardViewController {
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

extension AddCardViewController {
    private func fetchDataForTeamPickerView() {
        teamTextFieldPickerView.configureData(with: [
            "BUSUS", "KUBN", "MEMPH",
            "CSAK", "MNTLT", "NIKA",
            "ALLGRS", "VSPRST", "GLDB",
            "ZVZD", "NLAK", "CEMUN", "KFC",
        ])
    }
    
    private func fetchDataForScoredPlayerPickerView() {
        scoredPlayerTextFieldPickerView.configureData(with: [
            "Rakhimov A.",
            "Nachinkin I.",
            "Martynov D.",
            "Filatov K.."
        ])
    }
}
