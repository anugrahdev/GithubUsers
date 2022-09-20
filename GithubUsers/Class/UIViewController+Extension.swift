//
//  UIViewController+Extension.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 19/09/22.
//

import UIKit

extension UIViewController {
    func showNoInternetConnectionAlert() {
        let alert = UIAlertController(title: StringResources.noInternetTitle, message: StringResources.noInternetMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.backText, style: .default, handler: nil))
        present(alert, animated: true)
    }
}
