//
//  Repository+IdentifiableType.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import RxDataSources

extension Repository: IdentifiableType {
    
    var identity: Int {
        return id
    }
}
