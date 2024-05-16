//
//  AppIcon.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import Foundation

enum AppIcon: String, CaseIterable {
    case AppIconBlack
    case AppIconBlackRed
    case AppIconWhite
    case AppIconWhiteRed
    case AppIconBlackDisco
    case AppIconWhiteDisco
    case AppIconBoom
    case AppIconS4StarsBlack
    case AppIconS4StarsWhite
    case AppIconS4Police
    
    static func indexForCase(withValue stringValue: String) -> Int? {
        for (index, caseValue) in AppIcon.allCases.enumerated() {
            if caseValue.rawValue == stringValue {
                return index
            }
        }
        return nil
    }
}
