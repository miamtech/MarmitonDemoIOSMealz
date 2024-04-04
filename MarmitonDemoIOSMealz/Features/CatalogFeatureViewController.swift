//
//  CatalogViewController.swift
//  MarmitonDemoIOS
//
//  Created by Diarmuid McGonagle on 07/02/2024.
//

import UIKit
import MealzNavModuleIOS
import MealzIOSFramework

class CatalogFeatureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let catalogFeature = MealzCatalogFeatureUIKit(
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            catalogFeatureConstructor: MealzViewConfig.catalogConfig,
            myMealsViewOptions: MealzViewConfig.myMealsView
        )
        
        // Add the custom navigation controller as a child view controller
        addChild(catalogFeature)
        catalogFeature.view.frame = self.view.bounds
        view.addSubview(catalogFeature.view)
        catalogFeature.didMove(toParent: self)
    }
}


// i only use above because i want to use Storyboard
//let catalogFeature = MealzCatalogFeatureUIKit(
//    recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//    catalogFeatureConstructor: MealzViewConfig.catalogConfig,
//    myMealsViewOptions: MealzViewConfig.myMealsView
//)
