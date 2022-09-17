//
//  UserModel.swift
//
//  Created by Anang Nugraha on 16/09/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UserModel: Codable {

    var reposUrl: String?
    var receivedEventsUrl: String?
    var gistsUrl: String?
    var htmlUrl: String?
    var type: String?
    var gravatarId: String?
    var score: Int?
    var siteAdmin: Bool?
    var id: Int?
    var eventsUrl: String?
    var followersUrl: String?
    var starredUrl: String?
    var nodeId: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var username: String?
    var url: String?
    var avatarUrl: String?
    var followingUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case reposUrl = "repos_url"
        case receivedEventsUrl = "received_events_url"
        case gistsUrl = "gists_url"
        case htmlUrl = "html_url"
        case type = "type"
        case gravatarId = "gravatar_id"
        case score = "score"
        case siteAdmin = "site_admin"
        case id = "id"
        case eventsUrl = "events_url"
        case followersUrl = "followers_url"
        case starredUrl = "starred_url"
        case nodeId = "node_id"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case username = "login"
        case url = "url"
        case avatarUrl = "avatar_url"
        case followingUrl = "following_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reposUrl = try container.decodeIfPresent(String.self, forKey: .reposUrl)
        receivedEventsUrl = try container.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        gistsUrl = try container.decodeIfPresent(String.self, forKey: .gistsUrl)
        htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        gravatarId = try container.decodeIfPresent(String.self, forKey: .gravatarId)
        score = try container.decodeIfPresent(Int.self, forKey: .score)
        siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        eventsUrl = try container.decodeIfPresent(String.self, forKey: .eventsUrl)
        followersUrl = try container.decodeIfPresent(String.self, forKey: .followersUrl)
        starredUrl = try container.decodeIfPresent(String.self, forKey: .starredUrl)
        nodeId = try container.decodeIfPresent(String.self, forKey: .nodeId)
        subscriptionsUrl = try container.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        organizationsUrl = try container.decodeIfPresent(String.self, forKey: .organizationsUrl)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        followingUrl = try container.decodeIfPresent(String.self, forKey: .followingUrl)
    }

}

