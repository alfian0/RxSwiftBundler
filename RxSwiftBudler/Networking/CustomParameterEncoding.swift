//
//  CustomParameterEncoding.swift
//  RxSwiftBudler
//
//  Created by PayPro on 1/10/18.
//  Copyright © 2018 alfian.official. All rights reserved.
//

import Moya
import Alamofire

/*
 * This used for handle post that have URL paramaters and body parameters
 * Taken from : https://github.com/Moya/Moya/issues/1030
 */
struct CustomParameterEncoding: Moya.ParameterEncoding {
    
    public static var `default`: CustomParameterEncoding { return CustomParameterEncoding() }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        /*
         * Get url request
         */
        var req = try urlRequest.asURLRequest()
        
        guard let request = (req as NSURLRequest).mutableCopy() as? NSMutableURLRequest,
            let components = NSURLComponents(string: request.url!.absoluteString) else {
                return req
        }
        components.queryItems = [URLQueryItem]()
        
        /*
         * Why we need check method is post or get
         * Because get dont have httpBody if we set it will produce endless loop
         */
        if let parameters = parameters,
            let method = req.httpMethod {
            
            switch method {
            case Moya.Method.post.rawValue:
                
                let json = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
                req.httpBody = json
            default:
                
                for parameter in parameters {
                    components.queryItems?.append(URLQueryItem(name: parameter.key, value: "\(parameter.value)"))
                }
            }
        }
        
        req.url = components.url
        
        return req
    }
}
