//
//  AlertHelper.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

final class AlertHelper {
    static func showAlert(from viewController: UIViewController?, withTitle title: String, message: String) {
        guard let viewController = viewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
