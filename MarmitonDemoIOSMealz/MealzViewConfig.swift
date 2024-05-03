//
//  MealzViewConfig.swift
//  SampleUIKitIntegration
//
//  Created by Diarmuid McGonagle on 22/01/2024.
//

import Foundation
import MarmitonUIMealzIOS
import MealzUIModuleIOS
import MealzIOSFramework
import MealzNavModuleIOS
import mealzcore
import UIKit
import WebKit


let changeStore: () -> Void = {
    let htmlFileURL =  Bundle(identifier: "MarmitonUIMealzIOS-MarmitonUIMealzIOS-resources")!.url(forResource: "index", withExtension: "html", subdirectory: "Ressources")!
    
    var mealsWebView =  MealzWebView(url:htmlFileURL) { value in
        guard let posId = value as? String else { return }
        Mealz.User.shared.setStoreWithMealzId(storeId: posId)
    }
    
    UIApplication.shared.keyWindow?.rootViewController?.present(mealsWebView, animated: true)
    
}

let showCheckout: (_ url:String?) -> Void = {url in 
    guard let stringUrl = url , let url = URL(string:stringUrl) else { return }
     let request = URLRequest(url: url)
    
    let config = WKWebViewConfiguration()
    let webView = WKWebView(frame: .zero, configuration: config)
    webView.load(request)
    webView.translatesAutoresizingMaskIntoConstraints = false
    
    let viewController = UIViewController()
    viewController.view.addSubview(webView)
    NSLayoutConstraint.activate([
        webView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 0),
        webView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: 0),
        webView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: 0),
        webView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 0),
    ])
    
    if let sceneDelegate = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
       let keyWindow = sceneDelegate.windows.first(where: { $0.isKeyWindow }),
       let rootViewController = keyWindow.rootViewController {

        var topViewController = rootViewController
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        topViewController.present(viewController, animated: true)
    }
}

struct MealzViewConfig {
    
    // ----------------------------- RECIPE DETAILS ------------------------------
    
    static let recipeDetailsBaseViews = BasePageViewParameters(
//        loading: TypeSafeLoading(MarmitonLoadingView())
    )
    static let recipeDetailsViews = RecipeDetailsViewOptions(
        header: TypeSafeRecipeDetailsHeader(MarmitonRecipeDetailsHeaderView(changeStore: changeStore)),
        selectedControl: TypeSafeRecipeDetailsSelectedControl(MarmitonRecipeDetailsSelectedControlView())
//        numberOfIngredientsTitle: TypeSafeBaseTitle(EmptyTitleView())
//        steps: TypeSafeRecipeDetailsSteps(MarmitonRecipeDetailsStepsView()),
//        footer: TypeSafeRecipeDetailsFooter(MarmitonRecipeDetailsFooterView())
    )
    static let recipeDetailsProductsViews = RecipeDetailsProductViewOptions(
//        addedProduct: TypeSafeRecipeDetailsAddedProduct(MarmitonRecipeDetailsAddedProductView())
    )
    static let recipeDetailsConfig = RecipeDetailsFeatureConstructor(
        baseViews: recipeDetailsBaseViews,
        recipeDetailsViewOptions: recipeDetailsViews,
        recipeDetailsProductViewOptions: recipeDetailsProductsViews
    )
    
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
