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
        
    }
    
    func showErrorAlert(_ message: String) {
        
    }

}

extension Router {
    
    func setupSearchViewController() -> SearchVC {
        let wireframe = SearchWireframe(resolver: resolver)
        return wireframe.setupSearchViewController()
    }
    
}

