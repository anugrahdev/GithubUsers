//
//  FavoritesWireframe.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 18/09/22.
//  
//

import Foundation
import UIKit

class FavoritesWireframe: FavoritesWireframeProtocol {
    
    weak var controller: FavoritesVC?
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setupFavoritesViewController() -> FavoritesVC {
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter(interactor: interactor, wireframe: self)
        let view = FavoritesVC()
        interactor.delegate = presenter
        controller = view
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    
    func setLoadingIndicator(isHidden: Bool) {
        
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: StringResources.noInternetTitle, message: StringResources.noInternetMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.backText, style: .default, handler: nil))
        self.controller?.present(alert, animated: true)
    }
    
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: StringResources.errorLoadData, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.backText, style: .default, handler: nil))
        self.controller?.present(alert, animated: true)
    }
    
    func showFavoriteAlert() {
        let dialogMessage = UIAlertController(
            title: "",
            message: "You are successfully remove user from your favorite",
            preferredStyle: .alert)
         
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
         
        dialogMessage.addAction(ok)

        controller?.present(dialogMessage, animated: true, completion: nil)
    }

}

extension Router {
    
    func setupFavoritesViewController() -> FavoritesVC {
        let wireframe = FavoritesWireframe(resolver: resolver)
        return wireframe.setupFavoritesViewController()
    }
    
}
