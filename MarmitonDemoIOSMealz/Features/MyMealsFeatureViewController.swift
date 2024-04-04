//
//  MyMealsFeatureViewController.swift
//  MarmitonDemoIOS
//
//  Created by Diarmuid McGonagle on 07/02/2024.
//

import UIKit
import MealzNavModuleIOS

class MyMealsFeatureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myMealsFeature = MealzMyMealsFeatureUIKit(
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            myMealsContructor: MealzViewConfig.myMealsConfig
        )
        
        // Add the custom navigation controller as a child view controller
        addChild(myMealsFeature)
        myMealsFeature.view.frame = self.view.bounds
        view.addSubview(myMealsFeature.view)
        myMealsFeature.didMove(toParent: self)
    }
}


// i only use above because i want to use Storyboard
//let myMealsFeature = MealzMyMealsFeatureUIKit(
//    recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//    myMealsContructor: MealzViewConfig.myMealsConfig
//)
