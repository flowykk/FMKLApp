//
//  TextField+PickerView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 18.06.2024.
//

import UIKit

final class TextFieldPickerView: UIView, UITextFieldDelegate {
    private var data: [String] = [String]()
    
    public var textField: UITextField = UITextField()
    private let pickerView: UIPickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)

        configureUI()
    }
}

extension TextFieldPickerView {
    func setPlaceholder(with placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func setBackgroundColor(with color: UIColor) {
        textField.backgroundColor = color
    }
    
    func getTextFieldData() -> String {
        return textField.text ?? ""
    }
    
    func configureData(with data: [String]) {
        self.data = data
    }
}

extension TextFieldPickerView {
    private func configureUI() {
        configureTextField()
        configurePickerView()
    }
    
    private func configureTextField() {
        textField.delegate = self
        
        textField.font = UIFont(name: "Jellee-Roman", size: 18)
        textField.textColor = Constants.secondColor
        textField.layer.cornerRadius = 15
        textField.returnKeyType = .done
        textField.inputView = pickerView
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        textField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        textField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        
        addSubview(textField)
        textField.pinVertical(to: self)
        textField.pinHorizontal(to: self)
        textField.pinCenterX(to: self.centerXAnchor)
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension TextFieldPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = data[row]
        self.endEditing(true)
    }
}
