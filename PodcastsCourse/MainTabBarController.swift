//
//  MainTabBarController.swift
//  PodcastsCourse
//
//  Created by Yatin Sarbalia on 8/22/18.
//  Copyright © 2018 Yatin Sarbalia. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()

    UINavigationBar.appearance().prefersLargeTitles = true
    tabBar.tintColor = .purple

    setupViewController()
  }

  //MARK: Setup functions

  func setupViewController() {
    viewControllers = [
      generateNavController(with: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
      generateNavController(with: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
      generateNavController(with: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
    ]
  }

  //MARK:- Helper functions

  fileprivate func generateNavController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    rootViewController.navigationItem.title = title
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    return navController
  }
}
