//
//  FavoritesFeatureViewController.swift
//  MarmitonDemoIOS
//
//  Created by Diarmuid McGonagle on 07/02/2024.
//

import UIKit
import MealzNavModuleIOS

class FavoritesFeatureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favoritesFeature = MealzFavoritesFeatureUIKit(
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            favoritesFeatureConstructor: MealzViewConfig.favoritesConfig
        )
        
        // Add the custom navigation controller as a child view controller
        addChild(favoritesFeature)
        favoritesFeature.view.frame = self.view.bounds
        view.addSubview(favoritesFeature.view)
        favoritesFeature.didMove(toParent: self)
    }
}

// i only use above because i want to use Storyboard
//let favoritesFeature = MealzFavoritesFeatureUIKit(
//recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//favoritesFeatureConstructor: MealzViewConfig.favoritesConfig
//)
