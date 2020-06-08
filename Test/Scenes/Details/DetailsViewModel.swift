//
//  DetailsViewModel.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol DetailsViewModelInput: ViewModelInput {
}

extension DetailsViewModelInput {
    var input: DetailsViewModelInput { return self }
}

protocol DetailsViewModelOutput: ViewModelOutput {
    var repository: Driver<Repository> { get }
}

extension DetailsViewModelOutput where Self: ViewModelOutput {
    var output: DetailsViewModelOutput { return self }
}


class DetailsViewModel: ViewModelType, DetailsViewModelInput, DetailsViewModelOutput {
    typealias Dependency = Void
    
    private let repositorySubject = BehaviorRelay<Repository?>(value: nil)
    
    init(repository: Repository) {
        self.repositorySubject.accept(repository)
    }
    
    var repository: Driver<Repository> {
        return repositorySubject
            .asDriver(onErrorJustReturn: nil)
            //RxSwiftExt not imported
            .filter { $0 != nil }
            .map { $0! }
    }
}
