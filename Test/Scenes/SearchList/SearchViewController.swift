//
//  SearchViewController.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController, BindableType {

    @IBOutlet private weak var tableView: UITableView!
    private let searchBar = UISearchBar()
    
    typealias ViewModel = SearchViewModel
    var viewModel: ViewModel!
    
    private lazy var tableManager = SearchTableManager(with: tableView)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }

    
    func bindInput(_ input: SearchViewModelInput) {
        
        searchBar.rx.text
            .bind(to: input.searchText)
            .disposed(by: disposeBag)
        
        tableManager.selected
            .bind(to: input.selected)
            .disposed(by: disposeBag)
    }
    
    func bindOutput(_ output: SearchViewModelOutput) {
        
        output.repositories
            .bind(to: tableManager.items)
            .disposed(by: disposeBag)
    }
}

