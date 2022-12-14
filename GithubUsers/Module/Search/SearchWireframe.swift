//
//  SearchWireframe.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//  
//

import Foundation
import UIKit

class SearchWireframe: SearchWireframeProtocol {

    weak var controller: SearchVC?
    
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setupSearchViewController() -> SearchVC {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, wireframe: self)
        let view = SearchVC()
        interactor.delegate = presenter
        controller = view
        view.presenter = presenter
        presenter.view = view

        return view
    }
    
    func setLoadingIndicator(isHidden: Bool) {
        if isHidden {
            controller?.usersTableView.hideLoading()
        } else {
            controller?.usersTableView.showLoading()
        }
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
    
    func showFavoriteAlert(isSuccess: Bool) {
        let dialogMessage = UIAlertController(
            title: "",
            message: isSuccess ? "You are successfully add this user to your favorite :D" : "this user already added to your favorite list",
            preferredStyle: .alert)
         
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
         
        dialogMessage.addAction(ok)

        controller?.present(dialogMessage, animated: true, completion: nil)
    }

}

extension Router {
    
    func setupSearchViewController() -> SearchVC {
        let wireframe = SearchWireframe(resolver: resolver)
        return wireframe.setupSearchViewController()
    }
    
}

