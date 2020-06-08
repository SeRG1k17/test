//
//  BindableType.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import UIKit

protocol BindableType {
    
    associatedtype ViewModel: PresenterType
    
    var viewModel: ViewModel! { get set }
    
    func bindInput(_ input: ViewModel.Input)
    func bindOutput(_ output: ViewModel.Output)
}

extension BindableType where Self: UIViewController {
    
    @discardableResult
    mutating func bind(to model: ViewModel) -> UIViewController {
        
        viewModel = model
        loadViewIfNeeded()
        
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
        
        return self
    }
    
    func bindOutput(_ output: ViewModel.Output) {}
}
