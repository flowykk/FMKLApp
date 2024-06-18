//
//  TextField+PickerView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 18.06.2024.
//

import UIKit

final class TextFieldPickerView: UIView, UITextFieldDelegate {
    private var teams: [String] = [String]()
    
    public var teamTextField: UITextField = UITextField()
    private let teamPickerView: UIPickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)

        fetchData()
        configureUI()
    }
}

extension TextFieldPickerView {
    private func configureUI() {
        configureTeamTextField()
        configureTeamPickerView()
    }
    
    private func configureTeamTextField() {
        teamTextField.delegate = self
        
        teamTextField.placeholder = "Tap to select"
        teamTextField.backgroundColor = Constants.secondColor?.withAlphaComponent(0.15)
        teamTextField.font = UIFont(name: "Jellee-Roman", size: 18)
        teamTextField.textColor = Constants.secondColor
        teamTextField.layer.cornerRadius = 15
        teamTextField.returnKeyType = .done
        teamTextField.inputView = teamPickerView
        
        teamTextField.autocapitalizationType = .none
        teamTextField.autocorrectionType = .no
        
        teamTextField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        teamTextField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        teamTextField.leftViewMode = .always
        teamTextField.rightViewMode = .always
        
        addSubview(teamTextField)
        teamTextField.pinHorizontal(to: self, 10)
        teamTextField.setHeight(50)
        teamTextField.pinTop(to: self.topAnchor, 5)
        teamTextField.pinCenterX(to: self.centerXAnchor)
    }
    
    private func configureTeamPickerView() {
        teamPickerView.delegate = self
        teamPickerView.dataSource = self
    }
}

extension TextFieldPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teamTextField.text = teams[row]
        self.endEditing(true)
    }
}

extension TextFieldPickerView {
    private func fetchData() {
        teams = [
            "FC Bususiky",
            "Kuban' Peski",
            "Memphis",
            "CSAK",
            "FC Mentality",
            "FC Nika",
            "FC Alligators",
            "Vse Prosto",
            "Golden Boys",
            "FC Zvezda",
            "Na Laki",
            "CEM UNITED",
            "KFC",
        ]
    }
}
