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
    let usersPerPage = 10
    
    var allUsers: [UserModel]?
    var usersTotalCount: Int?
    var isLoadData: Bool
    var totalPage: Int
    var currentPage: Int
    var searchQuery: String
    
    init(interactor: SearchInteractorProtocol, wireframe: SearchWireframeProtocol) {
        self.allUsers = []
        self.interactor = interactor
        self.wireframe = wireframe
        self.totalPage = 1
        self.currentPage = 1
        self.isLoadData = true
        self.searchQuery = ""
    }
    
    func fetchSearchUsers() {
        wireframe.setLoadingIndicator(isHidden: false)
        interactor.getAllSearchUsers(request: SearchUserRequest(query: searchQuery, page: currentPage, per_page: usersPerPage))
    }
    
    func resetData() {
        allUsers = []
        usersTotalCount = 0
        totalPage = 0
        currentPage = 0
    }
    
}

extension SearchPresenter: SearchInteractorDelegate {
    
    func getAllSearchUserDidSuccess(_ result: GitUserModel?) {
        self.allUsers?.append(contentsOf: result?.items ?? [])
        usersTotalCount = result?.totalCount
        if let totalCount = result?.totalCount {
            var dataCurrentPage: Double = Double(totalCount / usersPerPage)
            dataCurrentPage.round(.up)
            totalPage = Int(dataCurrentPage)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.view?.reloadData()
        }
        isLoadData = false
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        
    }
    
    func userUnAuthorized() {
        
    }
    
}
