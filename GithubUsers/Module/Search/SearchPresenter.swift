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
    let usersPerPage = 15
    
    var allUsers: [UserModel]?
    var isLoadData: Bool
    var totalPage: Int
    var currentPage: Int
    var searchQuery: String
    var firstCalled: Bool
    
    init(interactor: SearchInteractorProtocol, wireframe: SearchWireframeProtocol) {
        self.allUsers = []
        self.interactor = interactor
        self.wireframe = wireframe
        self.totalPage = 1
        self.currentPage = 1
        self.isLoadData = false
        self.searchQuery = ""
        self.firstCalled = true
    }
    
    func fetchSearchUsers() {
        guard InternetConnectivity.isConnected() else {
            wireframe.showNoInternetAlert()
            return
        }
        wireframe.setLoadingIndicator(isHidden: false)
        interactor.getAllSearchUsers(request: SearchUserRequest(query: searchQuery, page: currentPage, per_page: usersPerPage))
    }
    
    func resetData() {
        allUsers = []
        totalPage = 1
        currentPage = 1
    }
    
    func saveFavoriteUser(with user: UserModel) {
        interactor.addUserToFavorite(user: user)
    }
    
}

extension SearchPresenter: SearchInteractorDelegate {
    
    func addUserToFavoriteResult(isSuccess: Bool) {
        wireframe.showFavoriteAlert(isSuccess: isSuccess)
    }
    
    func getAllSearchUserDidSuccess(_ result: GitUserModel?) {
        self.allUsers?.append(contentsOf: result?.items ?? [])
        if let totalCount = result?.totalCount {
            var dataCurrentPage: Double = Double(totalCount / usersPerPage)
            dataCurrentPage.round(.up)
            totalPage = Int(dataCurrentPage)
            firstCalled = false
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.view?.reloadData()
        }
        isLoadData = false
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.wireframe.showErrorAlert(error.localizedDescription)
        }
    }
    
}
