//
//  StandaloneRecipeDetailsViewController.swift
//  MarmitonDemoIOSMealz
//
//  Created by Diarmuid McGonagle on 04/04/2024.
//

import MealziOSSDK
import UIKit

class StandaloneRecipeDetailsViewController: UIViewController {
    let recipeId: String
    let openMyBasket: () -> Void
    
    init(recipeId: String, openMyBasket: @escaping () -> Void) {
        self.recipeId = recipeId
        self.openMyBasket = openMyBasket
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.init(url:Bundle(for: MealzCatalogFeatureUIKit.self).resourceURL!.appendingPathComponent("MealziOSSDK.bundle"))
        
        let recipesDetailsFeature = MealzRecipeDetailsFeatureUIKit(
            recipeId: recipeId,
            isMealzRecipe: false,
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig {
                self.openMyBasket()
            }
        )
        
        // Add the custom navigation controller as a child view controller
        addChild(recipesDetailsFeature)
        recipesDetailsFeature.view.frame = self.view.bounds
        view.addSubview(recipesDetailsFeature.view)
        recipesDetailsFeature.didMove(toParent: self)
    }
}
