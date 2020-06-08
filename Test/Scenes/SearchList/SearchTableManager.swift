//
//  SearchTableManager.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import RxSwift
import RxRelay

class SearchTableManager: TableManager, SectionedDataSourceAnimatable {
    
    typealias ItemType = Repository
    typealias SectionType = Int
    typealias CellType = ListTableViewCell
    
    let items = PublishRelay<[Repository]>()
    private let disposeBag = DisposeBag()
    
    private(set) lazy var dataSource: SectionedDataSource = {
        return SectionedDataSource(configureCell: { [weak self] _, tableView, indexPath, item -> UITableViewCell in
            
            guard let self = self else { return CellType() }
            return self.dequeue(for: tableView, at: indexPath, with: item)
        })
    }()
    
    override func setupTableView(_ tableView: UITableView) {
        super.setupTableView(tableView)
        
        tableView.tableFooterView = UIView()
        
        registerObservers()
    }
    
    override func register(for tableView: UITableView) {
        super.register(for: tableView)
        
        CellType.registerNib(for: tableView)
    }
    
    private func registerObservers() {
        
        items
            .map { [Model(model: 0, items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    var selected: Observable<Repository> {
        return tableView.rx.itemSelected
            .do(onNext: { (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map { self.dataSource.sectionModels[$0.section].items[$0.row] }
        .asObservable()
    }
    
    func configure(_ cell: ListTableViewCell, at indexPath: IndexPath, with item: Repository) {
        
        cell.name.text = item.name
        cell.fullName.text = item.fullName
        cell.language.text = item.language
        cell.stars.text = "\(item.stargazersCount)"
    }
}
