//
//  MealzViewConfig.swift
//  SampleUIKitIntegration
//
//  Created by Diarmuid McGonagle on 22/01/2024.
//

import Foundation
import MarmitonUIMealzIOS
import mealzcore
import MealziOSSDK
import UIKit
import WebKit

let changeStore: () -> Void = {
    let htmlFileURL = MarmitonUIMealzIOS.bundle.url(forResource: "index", withExtension: "html", subdirectory: "Ressources")!
    
    var mealsWebView = MealzStoreLocatorWebView(url: htmlFileURL) { value in
        guard let posId = value as? String else { return }
        Mealz.User.shared.setStoreWithMealzId(storeId: posId)
    }
    if let sceneDelegate = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
        let keyWindow = sceneDelegate.windows.first(where: { $0.isKeyWindow }),
        let rootViewController = keyWindow.rootViewController
    {
        // Find the topmost view controller which is not presenting another view controller
        var topViewController = rootViewController
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        // Present the new view controller from the topmost view controller
        topViewController.present(mealsWebView, animated: true)
    }
}

let showCheckout: (_ url: String?) -> Void = { urlString in
    
    guard let urlString = urlString else { return }
    guard let url = URL(string: urlString) else { return }
    
    let viewController = TransferBasketFeature(transferBasketUrl: url, retailerName: RetailerRepositoryCompanion.shared.retailerName ?? "").toUIKit()
    viewController.modalPresentationStyle = .overCurrentContext
    
    if let sceneDelegate = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
        let keyWindow = sceneDelegate.windows.first(where: { $0.isKeyWindow }),
        let rootViewController = keyWindow.rootViewController
    {
        var topViewController = rootViewController
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        topViewController.present(viewController, animated: true)
    }
}

enum MealzViewConfig {
    // ----------------------------- RECIPE DETAILS ------------------------------
    
    static let recipeDetailsBaseViews = BasePageViewParameters(
        //        loading: TypeSafeLoading(MarmitonLoadingView())
    )
    static let recipeDetailsViews = { (openMyBasket: @escaping () -> Void) -> RecipeDetailsViewOptions in
        RecipeDetailsViewOptions(
            floatingHeader: TypeSafeRecipeDetailsFloatingNavigation(MarmitonRecipeDetailsFloatingNavigationView()),
            header: TypeSafeRecipeDetailsHeader(MarmitonRecipeDetailsHeaderView(changeStore: changeStore)),
            tags: TypeSafeRecipeDetailsTags(MarmitonRecipeDetailsTagsView()),
            selectedControl: TypeSafeRecipeDetailsSelectedControl(MarmitonRecipeDetailsSelectedControlView()),
            footer: TypeSafeRecipeDetailsFooter(MarmitonRecipeDetailsFooterView(openMyBasket: openMyBasket)),
            ingredientsAtHome: TypeSafeNotInBasketProduct(MarmitonNotInBasketProductView()),
            unavailableIngredients: TypeSafeNotInBasketProduct(MarmitonNotInBasketProductView())
        )
    }

    static let recipeDetailsProductsViews = RecipeDetailsProductViewOptions(
        ignoredProduct: TypeSafeRecipeDetailsIgnoredProduct(MarmitonRecipeDetailsIgnoredProductView()),
        addedProduct: TypeSafeRecipeDetailsAddedProduct(MarmitonRecipeDetailsAddedProductView())
    )
    
    static let itemSelectorView = ItemSelectorViewOptions(
        searchBar: TypeSafeSearch(MarmitonGeneralSearch())
    )
    
    static let recipeDetailsConfig = { (openMyBasket: @escaping () -> Void) -> RecipeDetailsFeatureConstructor in
        RecipeDetailsFeatureConstructor(
            baseViews: recipeDetailsBaseViews,
            recipeDetailsViewOptions: recipeDetailsViews(openMyBasket),
            recipeDetailsProductViewOptions: recipeDetailsProductsViews,
            itemSelectorViewOptions: itemSelectorView
        )
    }
    
    // ---------------------------------- MY MEALS ----------------------------------
    
    static let myMealsView = NestedMyMealsViewOptions(
        title: TypeSafeBaseTitle(EmptyTitleView()),
        recipeCard: TypeSafeMyMealRecipeCard(MarmitonMyMealRecipeCard())
    )
    
    static let myMealsBaseView = BasePageViewParameters(
        empty: TypeSafeEmpty(MarmitonMyMealsEmpty())
    )
    
    // -------------------------------- MY PRODUCTS ----------------------------------
    
    static let myProductsBaseView = BasePageViewParameters(
        empty: TypeSafeEmpty(MarmitonMyMealsEmpty())
    )
    
    static let myProductsView = MyProductsViewOptions(
        productCard: TypeSafeMyProductsProductCard(MarmitonMyProductsProductCard())
    )
    
    // ---------------------------------- MY BASKET ----------------------------------
    
    static let myBasketView = MyBasketViewOptions(
        title: TypeSafeBaseTitle(MarmitonMyBasketTitle(changeStore: changeStore)),
        swapper: TypeSafeMyBasketSwapper(MarmitonMyBasketSwapper(onAddAnotherProduct: {}))
    )
    
    static let myBasketConfig = MyBasketFeatureConstructor(
        myBasketViewOptions: myBasketView,
        myMealsViewOptions: MyMealsViewOptions(nestedOptions: myMealsView),
        myMealsBaseViews: myMealsBaseView,
        myProductsViewOptions: myProductsView,
        myProductsBaseViews: myProductsBaseView,
        defaultTab: .products,
        navigateToCatalog: {},
        navigateToCheckout: showCheckout
    )
    
    // ---------------------------------- GET PRICE BUTTON ----------------------------------
    
    static let getPriceView = GetPriceButtonViewOptions(
        priceSuccess: TypeSafePriceSuccess(MarmitonGetPriceSuccessView()),
        buttonToGetPrice: TypeSafeEmpty(MarmitonGetPriceButtonView()),
        priceNotAvailable: TypeSafeEmpty(MarmitonPriceNotAvailableView())
    )
    
    static let getPriceParams = GetPriceButtonParameters(viewOptions: getPriceView)
    
    // ---------------------------------- SHOW RECIPE BUTTON ----------------------------------
    
    static let showRecipeDetailsView = ShowRecipeDetailsButtonViewOptions(
        buttonToShowRecipeDetails: TypeSafeShowRecipeDetailsButton(MarmitonShowRecipeDetailsButtonView()),
        recipeNotAvailable: TypeSafeEmpty(MarmitonRecipeNotAvailableView())
    )
}
