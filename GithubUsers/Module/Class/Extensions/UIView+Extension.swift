//
//  UIView+Extension.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 17/09/22.
//

import UIKit
extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: self.classForCoder), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
