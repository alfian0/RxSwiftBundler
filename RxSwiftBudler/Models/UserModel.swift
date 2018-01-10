//
//  UserModel.swift
//  RxSwiftBudler
//
//  Created by PayPro on 1/9/18.
//  Copyright © 2018 alfian.official. All rights reserved.
//

import ObjectMapper

class UserModel: Mappable {
    var id: Int = -1
    var login: String?
    var avatarUrl: String?
    var gravatarId: String?
    var url: String?
    var htmlUrl: String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var reposUrl: String?
    var eventsUrl: String?
    var receivedEventsUrl: String?
    var type: String?
    var siteAdmin: Bool = false
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
        avatarUrl <- map["avatar_ur"]
        gravatarId <- map["gravatar_id"]
        url <- map["url"]
        htmlUrl <- map["html_url"]
        followersUrl <- map["followers_url"]
        followingUrl <- map["following_url"]
        gistsUrl <- map["gist_url"]
        starredUrl <- map["starred_url"]
        subscriptionsUrl <- map["subscription_url"]
        organizationsUrl <- map["organizations_url"]
        reposUrl <- map["repos_url"]
        eventsUrl <- map["events_url"]
        receivedEventsUrl <- map["receivedEvents_url"]
        type <- map["type"]
        siteAdmin <- map["site_admin"]
    }
}
