//
//  FavoritesContract.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 18/09/22.
//  
//

import Foundation

protocol FavoritesViewProtocol: BaseViewProtocol {
    func reloadData()
}

protocol FavoritesPresenterProtocol: BasePresenterProtocol {
    var allUsers: [FavoriteUser]? { get set }
    
    func resetData()
    func fetchAllFavoriteUsers()
    func removeUserFromFavorite(user: FavoriteUser)
}

protocol FavoritesWireframeProtocol: BaseWireframeProtocol {
    func showFavoriteAlert()
}

protocol FavoritesInteractorProtocol: BaseInteractorProtocol {
    func getAllFavoriteUsers()
    func removeUserFromFavorite(user: FavoriteUser)
}

protocol FavoritesInteractorDelegate: BaseInteractorDelegate {
    func getAllFavoriteUsersDidSuccess(_ result: [FavoriteUser])
    func removeUserFromFavoriteDidSuccess()
}
