//  MainTabBarController.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import UIKit

class MainTabBarController: UITabBarController {

    var popularController  : PopularViewController!
    var topRatedController : TopRatedViewController!
    var upcomingController : UpcomingViewController!
    
    // MARK: - TAB BAR ITEMS SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Creating and setting up three main view controllers to navigate
         through them with tab bar click. Each one configure (get responese
         from API itself when it will be shown first time */
        setupTabBarItems()
    }
    
    
    /** Setting up Main Tab 3 items which will be shown*/
    private func setupTabBarItems() {
        
        popularController  = PopularViewController()
        topRatedController = TopRatedViewController()
        upcomingController = UpcomingViewController()
        
        setViewControllers([
            popularController,
            topRatedController,
            upcomingController
        ], animated: true)
        
        setupNames()
        setupImages()
    }
    
    private func setupNames() {
        popularController.title  = "Popular"
        topRatedController.title = "Top Rated"
        upcomingController.title = "Upcoming"
    }
    
    private func setupImages() {
        popularController.tabBarItem.image = UIImage(named: "popular")
        topRatedController.tabBarItem.image = UIImage(named: "toprated")
        upcomingController.tabBarItem.image = UIImage(named: "upcoming")
    }
}
