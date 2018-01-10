//
//  GithubAPI.swift
//  RxSwiftBudler
//
//  Created by PayPro on 1/10/18.
//  Copyright © 2018 alfian.official. All rights reserved.
//

import Moya

enum GithubAPI {
    case users(since: Int)
}

extension GithubAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
        
    var method: Method {
        switch self {
        case .users:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .users(let since):
            return [
                "since": since
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .users:
            return CustomParameterEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .users:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .users:
            return .request
        }
    }
    
    var validate: Bool {
        switch self {
        case .users:
            return true
        }
    }
}
