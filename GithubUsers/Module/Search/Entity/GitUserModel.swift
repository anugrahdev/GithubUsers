//
//  GitUserModel.swift
//
//  Created by Anang Nugraha on 16/09/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct GitUserModel: Codable {
    var incompleteResults: Bool?
    var totalCount: Int?
    var items: [UserModel]?

    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case totalCount = "total_count"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        incompleteResults = try container.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        items = try container.decodeIfPresent([UserModel].self, forKey: .items)
    }

}
