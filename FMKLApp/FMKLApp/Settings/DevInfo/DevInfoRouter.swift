//
//  DevInfoRouter.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 20.06.2024.
//

import UIKit
import SafariServices

final class DevInfoRouter {
    private weak var view: UIViewController?
    private let socialMediaUsername: String = "flowykk"
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    func showSocialMedia(appUrl: String, webUrl: String) {
        guard let appURL = URL(string: appUrl + socialMediaUsername),
              let webURL = URL(string: webUrl + socialMediaUsername) else {
            return
        }
    
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL)
            }
        }
    }
}
