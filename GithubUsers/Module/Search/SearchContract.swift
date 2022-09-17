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

    func fetchSearchUsers(with query: String)
}

protocol SearchWireframeProtocol: BaseWireframeProtocol {}

protocol SearchInteractorProtocol: BaseInteractorProtocol {
    func getAllSearchUsers(query: String)
}

protocol SearchInteractorDelegate: BaseInteractorDelegate {
    func getAllSearchUserDidSuccess(_ result: GitUserModel?)
}
