//
//  MyBasketViewController.swift
//  MarmitonDemoIOSMealz
//
//  Created by Diarmuid McGonagle on 04/04/2024.
//

import UIKit
import MealzNaviOSSDK

class MyBasketFeatureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myBasketFeature = MealzMyBasketFeatureUIKit(
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            myBasketContructor: MealzViewConfig.myBasketConfig
        )
        
        // Add the custom navigation controller as a child view controller
        addChild(myBasketFeature)
        myBasketFeature.view.frame = self.view.bounds
        view.addSubview(myBasketFeature.view)
        myBasketFeature.didMove(toParent: self)
    }
}

// i only use above because i want to use Storyboard
//let myBasketFeature = MealzMyBasketFeatureUIKit(
//    recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//    myBasketContructor: MealzViewConfig.myBasketConfig
//)
