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
    
    func configure(with model: UserModel) {
        userNameLabel.text = model.username
        if let avatarString = model.avatarUrl, let avatarUrl = URL(string: avatarString) {
            userAvatarImage.kf.setImage(with: avatarUrl, placeholder: AppImage.placeholder)
        }
    }
    
}
