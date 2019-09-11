//
//  MainTabBarController.swift
//  PetSaver
//
//  Created by Boaz Froog on 09/09/2019.
//  Copyright © 2019 Boaz Froog. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserSignIn()
        
    }
    
    func setupViewControllers() {
       let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeController())
        
        let petSearchController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: PetSearchController())
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController, petSearchController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
    fileprivate func isUserSignIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                DispatchQueue.main.async {
                    let loginController = LoginController()
                    let navController = UINavigationController(rootViewController: loginController)
                    
                    self.present(navController, animated: true, completion: nil)
                    self.present(LoginController(), animated: true, completion: nil)
                }
            } else {
                self.setupViewControllers()
            }
            
        }
    }
}
