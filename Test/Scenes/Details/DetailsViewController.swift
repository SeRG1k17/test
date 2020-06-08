//
//  DetailsViewController.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController, BindableType {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var language: UILabel!
    
    typealias ViewModel = DetailsViewModel
    var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func bindInput(_ input: ViewModel.Input) {
    }

    func bindOutput(_ output: ViewModel.Output) {
        
        output.repository
            .map { $0.name }
            .drive(name.rx.text)
            .disposed(by: disposeBag)
        
        output.repository
            .map { $0.fullName }
            .drive(fullName.rx.text)
            .disposed(by: disposeBag)
        
        output.repository
            .map { $0.language ?? "-" }
            .drive(language.rx.text)
            .disposed(by: disposeBag)
        
        output.repository
            .map { "\($0.stargazersCount)" }
            .drive(stars.rx.text)
            .disposed(by: disposeBag)
    }
}
