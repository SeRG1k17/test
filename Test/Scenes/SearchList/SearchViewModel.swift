//
//  ViewModel.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchViewModelInput: ViewModelInput {
    var searchText: PublishRelay<String?> { get }
    var selected: PublishRelay<Repository> { get }
}

extension SearchViewModelInput {
    var input: SearchViewModelInput { return self }
}

protocol SearchViewModelOutput: ViewModelOutput {
    var repositories: Observable<[Repository]> { get }
}

extension SearchViewModelOutput where Self: ViewModelOutput {
    var output: SearchViewModelOutput { return self }
}


class SearchViewModel: ViewModelType, SearchViewModelInput, SearchViewModelOutput {
    
    typealias Dependency = Searchable
    
    let searchText = PublishRelay<String?>()
    var selected = PublishRelay<Repository>()
    
    private let disposeBag = DisposeBag()
    private let searchService: Searchable
    private weak var navigationController: UINavigationController?
    
    init(searchService: Searchable, navigationController: UINavigationController) {
        self.searchService = searchService
        self.navigationController = navigationController
        
        registerObservers()
    }
    
    private func registerObservers() {
        
        //Controller must call navigation, just example
        selected
            .subscribe(onNext: { [navigationController] (repository: Repository) in
                
                var vc = DetailsViewController.instance()
                let vm = DetailsViewModel(repository: repository)
                vc.bind(to: vm)
                
                navigationController?.pushViewController(vc, animated: true)
            })
        .disposed(by: disposeBag)
    }
    
    var repositories: Observable<[Repository]> {
        return searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({ [unowned self] (text: String?) -> Single<[Repository]> in
                guard let text = text, !text.isEmpty else { return .just([]) }
                return self.searchService.repositories(for: text)
            })
    }
}
