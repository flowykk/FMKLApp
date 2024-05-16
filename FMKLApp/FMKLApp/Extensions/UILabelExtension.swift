//
//  UILabelExtension.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let range = fullText.range(of: changeText)
        let startIndex = range!.lowerBound
        let position = fullText.distance(from: fullText.startIndex, to: startIndex)
        
        let attribute = NSMutableAttributedString.init(string: fullText); attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Constants.accentColor!, range:NSRange(location: position, length: changeText.count))
        self.attributedText = attribute
    }
}
