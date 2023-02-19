//
//  APIRouter.swift
//  TV Programming Exercise
//
//  Created by Rushi Bhatt on 4/12/22.
//  Copyright © 2022 Jeffery Kuo. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

enum SystemError: Error {
    case networkError
    case decodingError
}

struct NetworkConstants {
    static let baseURL = "https://api.themoviedb.org"
    
    static let apiKey: String = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    
    static let language: String = ((Locale.current.languageCode ?? "en") + "-" + (Locale.current.regionCode ?? "US"))
    
    enum ParameterKeys: String {
        case apiKey = "api_key"
        case language = "language"
        case page = "page"
    }
}

enum APIRouter: Alamofire.URLRequestConvertible {
    
    case getPopularShows
    case getShowDetails(id: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .getPopularShows: return .get
        case .getShowDetails: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getPopularShows: return "/3/tv/popular"
        case .getShowDetails(let id): return "/3/tv/\(id)"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .getPopularShows:
            return [
                NetworkConstants.ParameterKeys.apiKey.rawValue: NetworkConstants.apiKey,
                NetworkConstants.ParameterKeys.language.rawValue: NetworkConstants.language,
                NetworkConstants.ParameterKeys.page.rawValue: 1
            ]
        case .getShowDetails(id: _):
            return [
                NetworkConstants.ParameterKeys.apiKey.rawValue: NetworkConstants.apiKey,
                NetworkConstants.ParameterKeys.language.rawValue: NetworkConstants.language
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        // Construct url
        let url = try NetworkConstants.baseURL.asURL()
        
        // Append path
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Determine HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Add query parameters to request
        if let parameters = parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
