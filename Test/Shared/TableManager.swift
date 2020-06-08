//
//  TableManager.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import UIKit

class TableManager: NSObject {
    
    weak var tableView: UITableView! {
        didSet { setupTableView(tableView) }
    }
    
    init(with tableView: UITableView) {
        defer { self.tableView = tableView }
        
        super.init()
    }
    
    func setupTableView(_ tableView: UITableView) {
        register(for: tableView)
    }
    
    func register(for tableView: UITableView) {}
}
