//
//  GithubErrorModel.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import Foundation

// MARK: - GithubErrorModel
struct GithubErrorModel: Codable {
    var message: String?
    var errors: [ErrorModel]?
    var documentationURL: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case errors = "errors"
        case documentationURL = "documentation_url"
    }
}

// MARK: - Error
struct ErrorModel: Codable {
    var resource: String?
    var field: String?
    var code: String?

    enum CodingKeys: String, CodingKey {
        case resource = "resource"
        case field = "field"
        case code = "code"
    }
}
