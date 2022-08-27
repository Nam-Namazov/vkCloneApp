//
//  TabBarController.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureTabBarControllers()
    }
    
    private func configureAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        let navBarAppearance = UINavigationBarAppearance()
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    private func configureTabBarControllers() {
        let feedViewController = createNavController(
            viewController: FeedViewController(),
            itemImage: "newspaper")
        
        let messengerViewController = createNavController(
            viewController: MessengerViewController(),
            itemImage: "message")
        
        let videosViewController = createNavController(
            viewController: VideosViewController(),
            itemImage: "video")
        
        let friendsViewController = createNavController(
            viewController: FriendsViewController(),
            itemImage: "person.badge.plus")
        
        let notificationsViewController = createNavController(
            viewController: NotificationsViewController(),
            itemImage: "bell")
        
        viewControllers = [feedViewController,
                           messengerViewController,
                           videosViewController,
                           notificationsViewController,
                           friendsViewController]
    }
    
    private func createNavController(viewController: UIViewController,
                                     itemImage: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(systemName: itemImage)
        tabBar.tintColor = .vkBlue
        return navController
    }
}
