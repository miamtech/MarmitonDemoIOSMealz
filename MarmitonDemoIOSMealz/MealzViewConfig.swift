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
import MealzNaviOSSDK
import MealzUIiOSSDK
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
    
    let viewController = TransferBasketFeature(transferBasketUrl: url, retailerName: "toto").toUIKit()
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
        return RecipeDetailsViewOptions(
            header: TypeSafeRecipeDetailsHeader(MarmitonRecipeDetailsHeaderView(changeStore: changeStore)),
            selectedControl: TypeSafeRecipeDetailsSelectedControl(MarmitonRecipeDetailsSelectedControlView()),
            //        numberOfIngredientsTitle: TypeSafeBaseTitle(EmptyTitleView())
            //        steps: TypeSafeRecipeDetailsSteps(MarmitonRecipeDetailsStepsView()),
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
        searchBar: TypeSafeSearch(MarmitonGeneralSearch()), 
        noResults: TypeSafeItemSelectorNoResults(MarmitonItemSelectorNoResultsView())
    )
    
    static let recipeDetailsConfig = { (openMyBasket: @escaping () -> Void) -> RecipeDetailsFeatureConstructor in
        return RecipeDetailsFeatureConstructor(
            baseViews: recipeDetailsBaseViews,
            recipeDetailsViewOptions: recipeDetailsViews(openMyBasket),
            recipeDetailsProductViewOptions: recipeDetailsProductsViews,
            itemSelectorViewOptions: itemSelectorView
        )
    }
    
    
    
    
    // -------------------------------- CATALOG ----------------------------------
    
    static let catalogView = CatalogViewOptions(
        //        catalogToolbar: TypeSafeCatalogToolbar(MarmitonCatalogToolbar()),
        //        resultsToolbar: TypeSafeCatalogToolbar(MarmitonCatalogResultsToolbar()),
        //        mealsInBasketButtonSuccess: TypeSafeMealsInBasketButtonSuccess(MarmitonMealsInBasketButtonSuccess())
    )
    
    static let catalogPackageView = CatalogPackageRowViewOptions(
        //        callToAction: TypeSafeCatalogPackageCTA(MarmitonCatalogPackageCTA()),
        //        recipeCard: TypeSafeCatalogRecipeCard(MarmitonRecipeCard(showYellowBanner: true))
    )
    
    static let recipesListView = CatalogRecipesListViewOptions(
        //        recipeCard: TypeSafeCatalogRecipeCard(MarmitonRecipeCard(showingOnCatalogResults: true))
    )
    
    static let catalogViewGridConfig = CatalogRecipesListGridConfig(
        recipeCardFillMaxWidth: false
    )
    
    static let catalogConfig = CatalogFeatureConstructor(
        usesPreferences: false,
        catalogViewOptions: catalogView,
        recipesListViewOptions: recipesListView,
        packageRowViewOptions: catalogPackageView,
        //        catalogSearchViewOptions: catalogSearchView,
        catalogViewGridConfig: catalogViewGridConfig
        //        catalogResultsGridConfig: catalogResultsGridConfig
    )
    
    // -------------------------------- FAVORITES ----------------------------------
    
    /* pass in your nav to the catalog here! */
    static let showCatalog = {}
    
    static let favoritesView = FavoritesViewOptions(
        //        recipeCard: TypeSafeCatalogRecipeCard(MarmitonRecipeCard())
    )
    
    static let favoritesConfig = FavoritesFeatureConstructor(
        favoritesViewOptions: favoritesView,
        navigateToCatalog: showCatalog
    )
    
    // ---------------------------------- MY MEALS ----------------------------------
    
    static let myMealsView = NestedMyMealsViewOptions(
        title: TypeSafeBaseTitle(EmptyTitleView())
        //        recipeCard: TypeSafeMyMealRecipeCard(MarmitonMyMealRecipeCard())
    )
    
    static let myMealsBaseView = BasePageViewParameters(
        empty: TypeSafeEmpty(MarmitonMyMealsEmpty())
    )
    
    // -------------------------------- MY PRODUCTS ----------------------------------
    
    static let myProductsBaseView = BasePageViewParameters(
        empty: TypeSafeEmpty(MarmitonMyMealsEmpty())
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
        myProductsBaseViews: myProductsBaseView,
//        catalogRecipesListGridConfig: myMealsGridConfig,
        navigateToCatalog: showCatalog,
        navigateToCheckout: showCheckout
    )
}
