//
//  OpenRecipeDetailsButtonViewController.swift
//  MarmitonDemoIOSMealz
//
//  Created by Diarmuid McGonagle on 04/04/2024.
//

import Foundation
import UIKit
import mealzcore
import MealziOSSDK
import SwiftUI

class OpenRecipeDetailsButtonViewController: UIViewController {
   
   let recipeDetailsLabel1 = UILabel()
   let recipeId1 = "22509"
   
   let recipeDetailsLabel2 = UILabel()
   let recipeId2 = "14472"
   
   let recipeDetailsLabel3 = UILabel()
   let recipeId3 = "20015"
   
   let deleteAllCacheButton = UIButton(type: .system)
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let recipeDetailsConfig = MealzViewConfig.recipeDetailsConfig({
         self.changeTabToMyBasket()
     })
      
      /* ----------------------------- RECIPE DETAILS 1 -----------------------------------------------*/
      // Configure the label
      recipeDetailsLabel1.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsLabel1.text = "Sample Recipe 1 (Mealz)"
      recipeDetailsLabel1.textAlignment = .center
      
      let recipeDetailsButton1 = MealzShowRecipeDetailsButton(
         recipeId: recipeId1,
         isMealzRecipe: false,
         recipeDetailsConstructor: recipeDetailsConfig,
         showRecipeDetailsButtonViewOptions: MealzViewConfig.showRecipeDetailsView
      )
      
      let showRecipeDetailsButton1 = UIHostingController(rootView: recipeDetailsButton1)
      showRecipeDetailsButton1.view.translatesAutoresizingMaskIntoConstraints = false
      
      // Replace UIButton with UIHostingController for SwiftUI component
      let priceView1 = GetPriceButton(params: MealzViewConfig.getPriceParams, recipeId: recipeId1, isMealzRecipe: false, guestNumber: 4)
      let getPriceView1 = UIHostingController(rootView: priceView1)
      getPriceView1.view.translatesAutoresizingMaskIntoConstraints = false
      
      /* ----------------------------- RECIPE DETAILS 2 -----------------------------------------------*/
      // Configure the label
      recipeDetailsLabel2.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsLabel2.text = "Sample Recipe 2 (Mealz)"
      recipeDetailsLabel2.textAlignment = .center
      
      // Configure the button
      let recipeDetailsButton2 = MealzShowRecipeDetailsButton(
         recipeId: recipeId2,
         isMealzRecipe: false,
         recipeDetailsConstructor: recipeDetailsConfig,
         showRecipeDetailsButtonViewOptions: MealzViewConfig.showRecipeDetailsView
      )
      let showRecipeDetailsButton2 = UIHostingController(rootView: recipeDetailsButton2)
      showRecipeDetailsButton2.view.translatesAutoresizingMaskIntoConstraints = false
      
      // Replace UIButton with UIHostingController for SwiftUI component
      let priceView2 = GetPriceButton(params: MealzViewConfig.getPriceParams, recipeId: "14472", isMealzRecipe: false, guestNumber: 4)
      let getPriceView2 = UIHostingController(rootView: priceView2)
      getPriceView2.view.translatesAutoresizingMaskIntoConstraints = false
      
      /* ----------------------------- RECIPE DETAILS 3 -----------------------------------------------*/
      // Configure the label
      recipeDetailsLabel3.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsLabel3.text = "Sample Recipe 3 (NOT Mealz)"
      recipeDetailsLabel3.textAlignment = .center
      
      // Configure the button
      let recipeDetailsButton3 = MealzShowRecipeDetailsButton(
         recipeId: recipeId3,
         isMealzRecipe: false,
         recipeDetailsConstructor: recipeDetailsConfig,
         showRecipeDetailsButtonViewOptions: MealzViewConfig.showRecipeDetailsView
      )
      let showRecipeDetailsButton3 = UIHostingController(rootView: recipeDetailsButton3)
      showRecipeDetailsButton3.view.translatesAutoresizingMaskIntoConstraints = false
      
      // Replace UIButton with UIHostingController for SwiftUI component
      let priceView3 = GetPriceButton(
         params: MealzViewConfig.getPriceParams,
         recipeId: recipeId3,
         isMealzRecipe: false,
         guestNumber: 4
      )
      let getPriceView3 = UIHostingController(rootView: priceView3)
      getPriceView3.view.translatesAutoresizingMaskIntoConstraints = false
      
      /* ----------------------------- DELETE ALL CACHE -----------------------------------------------*/
      deleteAllCacheButton.translatesAutoresizingMaskIntoConstraints = false
      deleteAllCacheButton.setTitle("Delete All Cache for next run", for: .normal)
      deleteAllCacheButton.addTarget(self, action: #selector(deleteAllCache), for: .touchUpInside)
      
      // Add the label, button, and hosting controllers to the view hierarchy
      view.addSubview(recipeDetailsLabel1)
      view.addSubview(showRecipeDetailsButton1.view)
      view.addSubview(getPriceView1.view)
      view.addSubview(recipeDetailsLabel2)
      view.addSubview(showRecipeDetailsButton2.view)
      view.addSubview(getPriceView2.view)
      view.addSubview(recipeDetailsLabel3)
      view.addSubview(showRecipeDetailsButton3.view)
      view.addSubview(getPriceView3.view)
      view.addSubview(deleteAllCacheButton)
      
      // Constraints for the label
      NSLayoutConstraint.activate([
         recipeDetailsLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // 20 points from the top of the safe area
         recipeDetailsLabel1.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsLabel1.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         showRecipeDetailsButton1.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         showRecipeDetailsButton1.view.topAnchor.constraint(equalTo: recipeDetailsLabel1.bottomAnchor, constant: 20),
         showRecipeDetailsButton1.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         showRecipeDetailsButton1.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         showRecipeDetailsButton1.view.heightAnchor.constraint(equalToConstant: 40) // Increase the height to 100 or more
      ])
      
      // Constraints for the UIHostingController view
      NSLayoutConstraint.activate([
         getPriceView1.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         getPriceView1.view.topAnchor.constraint(equalTo: showRecipeDetailsButton1.view.bottomAnchor, constant: 20), // Position button below the label
         getPriceView1.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         getPriceView1.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         getPriceView1.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
      ])
      
      // Repeat similar constraints for the second set of components
      NSLayoutConstraint.activate([
         recipeDetailsLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsLabel2.topAnchor.constraint(equalTo: getPriceView1.view.bottomAnchor, constant: 70), // Position button below the label
         recipeDetailsLabel2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsLabel2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         showRecipeDetailsButton2.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         showRecipeDetailsButton2.view.topAnchor.constraint(equalTo: recipeDetailsLabel2.bottomAnchor, constant: 20),
         showRecipeDetailsButton2.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         showRecipeDetailsButton2.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         showRecipeDetailsButton2.view.heightAnchor.constraint(equalToConstant: 40) // Increase the height to 100 or more
      ])
      
      // Constraints for the UIHostingController view
      NSLayoutConstraint.activate([
         getPriceView2.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         getPriceView2.view.topAnchor.constraint(equalTo: showRecipeDetailsButton2.view.bottomAnchor, constant: 20), // Position button below the label
         getPriceView2.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         getPriceView2.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         getPriceView2.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
      ])
      
      // Repeat similar constraints for the second set of components
      NSLayoutConstraint.activate([
         recipeDetailsLabel3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsLabel3.topAnchor.constraint(equalTo: getPriceView2.view.bottomAnchor, constant: 70), // Position button below the label
         recipeDetailsLabel3.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsLabel3.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         showRecipeDetailsButton3.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         showRecipeDetailsButton3.view.topAnchor.constraint(equalTo: recipeDetailsLabel3.bottomAnchor, constant: 20),
         showRecipeDetailsButton3.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         showRecipeDetailsButton3.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         showRecipeDetailsButton3.view.heightAnchor.constraint(equalToConstant: 40) // Increase the height to 100 or more
      ])
      
      // Constraints for the UIHostingController view
      NSLayoutConstraint.activate([
         getPriceView3.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         getPriceView3.view.topAnchor.constraint(equalTo: showRecipeDetailsButton3.view.bottomAnchor, constant: 20), // Position button below the label
         getPriceView3.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         getPriceView3.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         getPriceView3.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
      ])
      
      
      NSLayoutConstraint.activate([
         deleteAllCacheButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         deleteAllCacheButton.topAnchor.constraint(equalTo: getPriceView3.view.bottomAnchor, constant: 20), // Position button below the label
         deleteAllCacheButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         deleteAllCacheButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      // Additional UI setup
      view.backgroundColor = .white
      
      // Add hosting controllers as child view controllers
      self.addChild(showRecipeDetailsButton1)
      showRecipeDetailsButton1.didMove(toParent: self)
      
      self.addChild(getPriceView1)
      getPriceView1.didMove(toParent: self)
      
      self.addChild(showRecipeDetailsButton2)
      showRecipeDetailsButton2.didMove(toParent: self)
      
      self.addChild(getPriceView2)
      getPriceView2.didMove(toParent: self)
      
      self.addChild(showRecipeDetailsButton3)
      showRecipeDetailsButton3.didMove(toParent: self)
      
      self.addChild(getPriceView3)
      getPriceView3.didMove(toParent: self)
   }
   
   func changeTabToMyBasket() {
      self.tabBarController?.selectedIndex = 1
   }
   
   @objc func deleteAllCache() {
      let defaults = UserDefaults.standard
      if let domain = Bundle.main.bundleIdentifier {
         defaults.removePersistentDomain(forName: domain)
         defaults.synchronize()
         print("All UserDefaults data cleared.")
      }
   }
}
