//
//  SearchPresenter.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//  
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {

    // MARK: Properties
    weak var view: SearchViewProtocol?
    let interactor: SearchInteractorProtocol
    let wireframe: SearchWireframeProtocol
    
    var allUsers: [UserModel]?
    
    init(interactor: SearchInteractorProtocol, wireframe: SearchWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func fetchSearchUsers(with query: String) {
        wireframe.setLoadingIndicator(isHidden: false)
        interactor.getAllSearchUsers(query: query)
    }
}

extension SearchPresenter: SearchInteractorDelegate {
    
    func getAllSearchUserDidSuccess(_ result: GitUserModel?) {
        allUsers = result?.items
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.view?.reloadData()
        }
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        
    }
    
    func userUnAuthorized() {
        
    }
    
}
