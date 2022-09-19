//
//  SearchContract.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//  
//

import Foundation

protocol SearchViewProtocol: BaseViewProtocol {
    func reloadData()
}

protocol SearchPresenterProtocol: BasePresenterProtocol {
    var allUsers: [UserModel]? { get set }
    var totalPage: Int { get }
    var currentPage: Int { get set }
    var isLoadData: Bool { get set }
    var searchQuery: String { get set }
    var firstCalled: Bool { get set }
    
    func fetchSearchUsers()
    func resetData()
    func saveFavoriteUser(with user: UserModel)
}

protocol SearchWireframeProtocol: BaseWireframeProtocol {
    func showFavoriteAlert(isSuccess: Bool)
}

protocol SearchInteractorProtocol: BaseInteractorProtocol {
    func addUserToFavorite(user: UserModel)
    func getAllSearchUsers(request: SearchUserRequest)
}

protocol SearchInteractorDelegate: BaseInteractorDelegate {
    func getAllSearchUserDidSuccess(_ result: GitUserModel?)
    func addUserToFavoriteResult(isSuccess: Bool)
}
