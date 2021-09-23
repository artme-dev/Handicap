//
//  MainTabBarController.swift
//  HandicapCalculator
//
//  Created by Артём on 21.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupViewControllers()
    }
    
    private func configureAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupViewControllers() {
        viewControllers = [
            createNavController(for: ModuleBuilder.createHandicapModule(),
                                title: "Handicap",
                                image: UIImage(named: "ScoreIcon")!),
            
            createNavController(for: ModuleBuilder.createScoreModule(),
                                title: "Scores",
                                image: UIImage(named: "CourseIcon")!)
        
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UINavigationController {
        
        let navViewController = UINavigationController(rootViewController: rootViewController)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = image
        navViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navViewController
    }
}
