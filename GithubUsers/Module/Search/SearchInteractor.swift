//
//  SearchInteractor.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//  
//

import Foundation

class SearchInteractor: SearchInteractorProtocol {

    // MARK: Properties
    weak var delegate: SearchInteractorDelegate?
    
    func getAllSearchUsers(query: String) {
        let searchUserUrl = "\(Constants.baseURL)search/users?q=\(query)"
        
        RestApiServices.shared.request(url: searchUserUrl) { [weak self] (usersResult: GitUserModel) in
            self?.delegate?.getAllSearchUserDidSuccess(usersResult)
        } failure: { [weak self] error in
            self?.delegate?.serviceRequestDidFail(error)
        }
    }
}
