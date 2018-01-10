//
//  AppViewModel.swift
//  RxSwiftBudler
//
//  Created by PayPro on 1/9/18.
//  Copyright © 2018 alfian.official. All rights reserved.
//

import Moya
import RxSwift
import ObjectMapper

struct AppViewModel {
    
    var responseStream: Observable<[UserModel]>!
    
    private var provider: RxMoyaProvider<GithubAPI>!
    
    init(provider: RxMoyaProvider<GithubAPI>) {
        self.provider = provider
        self.responseStream = self.response()
    }
    
    private func response() -> Observable<[UserModel]> {
        return provider.request(.users(since: 1))
            .flatMap({ (response) -> Observable<Array<[String : Any]>?> in
                do {
                    let json = try response.mapJSON()
                    return Observable.just(json as? Array<[String : Any]>)
                } catch let error {
                    return Observable.error(error)
                }
            })
            .map { (users) -> [UserModel] in
                var userModels = [UserModel]()
                guard let `users` = users else { return [] }
                for user in users {
                    guard let userModel = UserModel(JSON: user) else {
                        continue
                    }
                    userModels.append(userModel)
                }
                return userModels
            }
    }
}
