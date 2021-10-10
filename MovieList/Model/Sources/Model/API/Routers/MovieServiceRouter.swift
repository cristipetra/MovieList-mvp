//
//  File.swift
//  
//
//  Created by Cristian Petra on 08.10.2021.
//

import Foundation
import Alamofire

enum MovieServiceRouter: URLRequestConvertible {
    case search(String)
    
    var path: String {
        switch self {
        case .search:
            return CoreService.apiVer + "/search/movie"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let search):
            return ["query": "\(search)", "api_key": "48bfc8fbc77e2dd9fc73fe33243b3d48"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .search:
            return URLEncoding.default
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: CoreService.shared.baseURL())!
        let urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        return try encoding.encode(urlRequest, with: parameters)
    }
}
