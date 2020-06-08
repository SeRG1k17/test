//
//  Repository.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import Foundation

struct Repository: Codable, Equatable {
    
    let id: Int
    let language: String?
    let name: String
    let fullName: String
    let stargazersCount: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        name = try container.decode(String.self, forKey: .name)
        fullName = try container.decode(String.self, forKey: .fullName)
        stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
    }
}
