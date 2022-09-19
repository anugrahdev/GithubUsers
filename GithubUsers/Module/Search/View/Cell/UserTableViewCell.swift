//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var identifier: String = "UserTableViewCell"
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAvatarImage: UIImageView!
    
    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(avatarUrl: String, username: String) {
        userNameLabel.text = username
        if let avatarUrl = URL(string: avatarUrl) {
            userAvatarImage.kf.setImage(with: avatarUrl, placeholder: AppImage.placeholder)
        }
    }
    
}
