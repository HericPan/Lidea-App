//
//  UIController Alert Manager.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/23.
//

import Foundation
import UIKit

class UIControllerAlertManager {
    static let instance = UIControllerAlertManager()
    
    func debugNotification(view: UIView) {
        let alert = UIAlertController(title: "开发施工中", message: "此功能暂不开放", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "好吧", style: .default)
        alert.addAction(defaultAction)
        view.window?.rootViewController?.present(alert, animated: true)
    }
    
    func customAlert(view: UIView, title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(defaultAction)
        view.window?.rootViewController?.present(alert, animated: true)
    }
}
