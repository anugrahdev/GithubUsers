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
    
    func getAllSearchUsers(request: SearchUserRequest) {
        let searchUserUrl = "\(Constants.baseURL)search/users?q=\(request.query)&page=\(request.page)&per_page=\(request.per_page)"
        
        RestApiServices.shared.request(url: searchUserUrl) { [weak self] (usersResult: GitUserModel) in
            self?.delegate?.getAllSearchUserDidSuccess(usersResult)
        } failure: { [weak self] error in
            self?.delegate?.serviceRequestDidFail(error)
        }
    }
    
    func addUserToFavorite(user: FavoriteUser) {
        
    }
    
}
