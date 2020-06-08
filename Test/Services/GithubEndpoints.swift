//
//  GithubEndpoints.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import Moya

enum Github {
    case repos(String)
}

extension Github: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError()
        }
        return url
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var path: String {
        switch self {
        case .repos(let name):
            return "/users/\(name)/repos"
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
}
