//
//  UIViewController+.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 26/1/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, messageBody: String) {
        let alert = UIAlertController(title: title, message: messageBody, preferredStyle: .alert)
        let actionClose = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(actionClose)
        self.present(alert, animated: true)
    }
}
