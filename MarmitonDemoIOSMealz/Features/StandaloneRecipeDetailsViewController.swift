//
//  StandaloneRecipeDetailsViewController.swift
//  MarmitonDemoIOSMealz
//
//  Created by Diarmuid McGonagle on 04/04/2024.
//

import UIKit
import MealzNaviOSSDK

class StandaloneRecipeDetailsViewController: UIViewController {
    let recipeId: String
    
    init(recipeId: String) {
        self.recipeId = recipeId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recipesDetailsFeature = MealzRecipeDetailsFeatureUIKit(
            recipeId: recipeId,
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig
        )
        
        // Add the custom navigation controller as a child view controller
        addChild(recipesDetailsFeature)
        recipesDetailsFeature.view.frame = self.view.bounds
        view.addSubview(recipesDetailsFeature.view)
        recipesDetailsFeature.didMove(toParent: self)
    }
}
