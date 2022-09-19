//
//  FavoritesInteractor.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 18/09/22.
//  
//

import Foundation

class FavoritesInteractor: FavoritesInteractorProtocol {
    // MARK: Properties
    weak var delegate: FavoritesInteractorDelegate?
    
    func getAllFavoriteUsers() {
        delegate?.getAllFavoriteUsersDidSuccess(CoreDataManager.shared.getAllFavoriteUsers())
    }
    
    func removeUserFromFavorite(user: FavoriteUser) {
        CoreDataManager.shared.removeFromFavorite(user: user)
    }
    
}
