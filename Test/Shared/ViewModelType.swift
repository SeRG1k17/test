//
//  ViewModelType.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import Foundation

protocol ViewModelType: PresenterType {
    
    associatedtype Dependency
    //var services: Dependency { get }
    //init(dependency: Dependency)
}

protocol PresenterType {
    
    associatedtype Input//: ViewModelInput
    associatedtype Output//: ViewModelOutput
    
    var input: Input { get }
    var output: Output { get }
}

protocol ViewModelInput {}
protocol ViewModelOutput {}
