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
    
    func createModule() -> SearchVC {
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
        
    }
    
    func showNoInternetAlert() {
        
    }
    
    func showErrorAlert(_ message: String) {
        
    }

}
