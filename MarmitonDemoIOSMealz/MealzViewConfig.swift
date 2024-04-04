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

struct MealzViewConfig {
    
    // ----------------------------- RECIPE DETAILS ------------------------------
    
    static let recipeDetailsBaseViews = BasePageViewParameters(
//        loading: TypeSafeLoading(MarmitonLoadingView())
    )
    static let recipeDetailsViews = RecipeDetailsViewOptions(
        header: TypeSafeRecipeDetailsHeader(MarmitonRecipeDetailsHeaderView()),
        selectedControl: TypeSafeRecipeDetailsSelectedControl(MarmitonRecipeDetailsSelectedControlView())
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
    
    static let myMealsView = MyMealsViewOptions(
//        title: TypeSafeBaseTitle(MarmitonMyMealsTitle()),
//        recipeCard: TypeSafeMyMealRecipeCard(MarmitonMyMealRecipeCard())
    )
    
    static let myMealsConfig = MyMealsFeatureConstructor(
        myMealsViewOptions: myMealsView,
//        catalogRecipesListGridConfig: myMealsGridConfig,
        navigateToCatalog: showCatalog
    )
    
}
