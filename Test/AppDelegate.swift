//
//  AppDelegate.swift
//  Test
//
//  Created by Sergey Pugach on 6/8/20.
//  Copyright © 2020 Sergey Pugach. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var searchService: Searchable = SearchService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        var viewController = SearchViewController.instance()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = SearchViewModel(
            searchService: searchService,
            navigationController: navigationController
        )
        
        viewController.bind(to: viewModel)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

