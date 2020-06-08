//
//  SearchService.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol Searchable {
    func repositories(for text: String) -> Single<[Repository]>
}

class SearchService: Searchable {
    
    private lazy var provider = MoyaProvider<Github>()
    private lazy var decoder: JSONDecoder = {
       let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func repositories(for text: String) -> Single<[Repository]> {
        return provider.rx.request(.repos(text))
            //.debug()
            .map([Repository].self, using: decoder)
            .catchErrorJustReturn([])
    }
}
