//
//  UITableView+Extension.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 17/09/22.
//

import Foundation
import UIKit

public extension UITableView {
    
    internal func setEmptyView(title: String) {
        let emptyView = EmptyResultViewBuilder()
            .setEmpty(title)
            .build()
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}
