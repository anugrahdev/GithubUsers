//
//  FavoritesPresenter.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 18/09/22.
//  
//

import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {

    // MARK: Properties
    weak var view: FavoritesViewProtocol?
    let interactor: FavoritesInteractorProtocol
    let wireframe: FavoritesWireframeProtocol
    var allUsers: [FavoriteUser]?
    
    init(interactor: FavoritesInteractorProtocol, wireframe: FavoritesWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.allUsers = []
    }
    
    func fetchAllFavoriteUsers() {
        guard InternetConnectivity.isConnected() else {
            wireframe.showNoInternetAlert()
            return
        }
        interactor.getAllFavoriteUsers()
    }
    
    func resetData() {
        allUsers = []
        fetchAllFavoriteUsers()
    }
    
    func removeUserFromFavorite(user: FavoriteUser) {
        interactor.removeUserFromFavorite(user: user)
    }
    
}

extension FavoritesPresenter: FavoritesInteractorDelegate {
    
    func getAllFavoriteUsersDidSuccess(_ result: [FavoriteUser]) {
        allUsers = result
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func removeUserFromFavoriteDidSuccess() {
        wireframe.showFavoriteAlert()
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.wireframe.showErrorAlert(error.localizedDescription)
        }
    }
}
