//
//  MainTabBarViewController.swift
//  Phimpme
//
//  Created by JOGENDRA on 22/03/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit
import NMAnimatedTabBarItem

enum TabBarPage : Int {
    case camera
    case gallery
    case accounts
}

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var animatedTabBar = NMAnimateTabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 2
        self.delegate = self
    }

    //MARK: - UITabBarControllerDelegate

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let indexOfTab = tabBarController.viewControllers?.index(of:viewController)
        var animationType:NMAnimationtype?
        switch indexOfTab {
        case TabBarPage.camera.rawValue?:
            animationType = NMAnimationtype.Bounce
        case TabBarPage.gallery.rawValue?:
            animationType = NMAnimationtype.Transition
            animatedTabBar.transitionOptions = UIViewAnimationOptions.transitionFlipFromBottom
        case TabBarPage.accounts.rawValue?:
            animationType = NMAnimationtype.Rotation
            animatedTabBar.direction = NMRotationDirection.right
        default:
            break
        }
        animatedTabBar.animateTabBarItem(self.tabBar, indexOfTab!, animationType!)
        return true
    }

}
