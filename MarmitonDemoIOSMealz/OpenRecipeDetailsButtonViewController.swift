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
    let recipeDetailsButton1 = UIButton(type: .system)
    
    let recipeDetailsLabel2 = UILabel()
    let recipeDetailsButton2 = UIButton(type: .system)
   
   let recipeDetailsLabel3 = UILabel()
   let recipeDetailsButton3 = UIButton(type: .system)
    
    let deleteAllCacheButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* ----------------------------- RECIPE DETAILS 1 -----------------------------------------------*/
        // Configure the label
        recipeDetailsLabel1.translatesAutoresizingMaskIntoConstraints = false
        recipeDetailsLabel1.text = "Sample Recipe 1 (Mealz)"
        recipeDetailsLabel1.textAlignment = .center
        
        // Configure the button
        recipeDetailsButton1.translatesAutoresizingMaskIntoConstraints = false
        recipeDetailsButton1.setTitle("Launch", for: .normal)
        recipeDetailsButton1.addTarget(self, action: #selector(launchRecipeDetails1), for: .touchUpInside)
        
        // Replace UIButton with UIHostingController for SwiftUI component
       let priceView1 = GetPriceButton(params: MealzViewConfig.getPriceParams, recipeId: "22509", isMealzRecipe: false, guestNumber: 4)
        let hostingController1 = UIHostingController(rootView: priceView1)
        hostingController1.view.translatesAutoresizingMaskIntoConstraints = false
        
        /* ----------------------------- RECIPE DETAILS 2 -----------------------------------------------*/
        // Configure the label
        recipeDetailsLabel2.translatesAutoresizingMaskIntoConstraints = false
        recipeDetailsLabel2.text = "Sample Recipe 2 (Mealz)"
        recipeDetailsLabel2.textAlignment = .center
        
        // Configure the button
        recipeDetailsButton2.translatesAutoresizingMaskIntoConstraints = false
        recipeDetailsButton2.setTitle("Launch", for: .normal)
        recipeDetailsButton2.addTarget(self, action: #selector(launchRecipeDetails2), for: .touchUpInside)
        
        // Replace UIButton with UIHostingController for SwiftUI component
        let priceView2 = GetPriceButton(params: MealzViewConfig.getPriceParams, recipeId: "14472", isMealzRecipe: false, guestNumber: 4)
        let hostingController2 = UIHostingController(rootView: priceView2)
        hostingController2.view.translatesAutoresizingMaskIntoConstraints = false
       
       /* ----------------------------- RECIPE DETAILS 3 -----------------------------------------------*/
       // Configure the label
       recipeDetailsLabel3.translatesAutoresizingMaskIntoConstraints = false
       recipeDetailsLabel3.text = "Sample Recipe 3 (NOT Mealz)"
       recipeDetailsLabel3.textAlignment = .center
       
       // Configure the button
       recipeDetailsButton3.translatesAutoresizingMaskIntoConstraints = false
       recipeDetailsButton3.setTitle("Launch", for: .normal)
//       recipeDetailsButton3.addTarget(self, action: #selector(launchRecipeDetails3), for: .touchUpInside)
       
       // Replace UIButton with UIHostingController for SwiftUI component
       let priceView3 = GetPriceButton(params: MealzViewConfig.getPriceParams, recipeId: "", isMealzRecipe: false, guestNumber: 4)
       let hostingController3 = UIHostingController(rootView: priceView3)
       hostingController3.view.translatesAutoresizingMaskIntoConstraints = false
        
        /* ----------------------------- DELETE ALL CACHE -----------------------------------------------*/
        deleteAllCacheButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAllCacheButton.setTitle("Delete All Cache for next run", for: .normal)
        deleteAllCacheButton.addTarget(self, action: #selector(deleteAllCache), for: .touchUpInside)
        
        // Add the label, button, and hosting controllers to the view hierarchy
        view.addSubview(recipeDetailsLabel1)
        view.addSubview(recipeDetailsButton1)
        view.addSubview(hostingController1.view)
        view.addSubview(recipeDetailsLabel2)
        view.addSubview(recipeDetailsButton2)
        view.addSubview(hostingController2.view)
       view.addSubview(recipeDetailsLabel3)
       view.addSubview(recipeDetailsButton3)
       view.addSubview(hostingController3.view)
        view.addSubview(deleteAllCacheButton)
        
        // Constraints for the label
        NSLayoutConstraint.activate([
            recipeDetailsLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeDetailsLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // 20 points from the top of the safe area
            recipeDetailsLabel1.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            recipeDetailsLabel1.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            recipeDetailsButton1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeDetailsButton1.topAnchor.constraint(equalTo: recipeDetailsLabel1.bottomAnchor, constant: 20), // Position button below the label
            recipeDetailsButton1.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            recipeDetailsButton1.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for the UIHostingController view
       // Constraints for the UIHostingController view
       NSLayoutConstraint.activate([
           hostingController1.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           hostingController1.view.topAnchor.constraint(equalTo: recipeDetailsButton1.bottomAnchor, constant: 20), // Position button below the label
           hostingController1.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           hostingController1.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           hostingController1.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
       ])

        
        // Repeat similar constraints for the second set of components
        NSLayoutConstraint.activate([
            recipeDetailsLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeDetailsLabel2.topAnchor.constraint(equalTo: hostingController1.view.bottomAnchor, constant: 50), // Position button below the label
            recipeDetailsLabel2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            recipeDetailsLabel2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            recipeDetailsButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeDetailsButton2.topAnchor.constraint(equalTo: recipeDetailsLabel2.bottomAnchor, constant: 20), // Position button below the label
            recipeDetailsButton2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            recipeDetailsButton2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
       // Constraints for the UIHostingController view
       NSLayoutConstraint.activate([
           hostingController2.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           hostingController2.view.topAnchor.constraint(equalTo: recipeDetailsButton2.bottomAnchor, constant: 20), // Position button below the label
           hostingController2.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           hostingController2.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           hostingController2.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
       ])
       
       // Repeat similar constraints for the second set of components
       NSLayoutConstraint.activate([
           recipeDetailsLabel3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           recipeDetailsLabel3.topAnchor.constraint(equalTo: hostingController2.view.bottomAnchor, constant: 50), // Position button below the label
           recipeDetailsLabel3.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
           recipeDetailsLabel3.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
       ])
       
       NSLayoutConstraint.activate([
           recipeDetailsButton3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           recipeDetailsButton3.topAnchor.constraint(equalTo: recipeDetailsLabel3.bottomAnchor, constant: 20), // Position button below the label
           recipeDetailsButton3.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
           recipeDetailsButton3.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
       ])
       
      // Constraints for the UIHostingController view
      NSLayoutConstraint.activate([
          hostingController3.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          hostingController3.view.topAnchor.constraint(equalTo: recipeDetailsButton3.bottomAnchor, constant: 20), // Position button below the label
          hostingController3.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          hostingController3.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          hostingController3.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
      ])

        
        NSLayoutConstraint.activate([
            deleteAllCacheButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteAllCacheButton.topAnchor.constraint(equalTo: hostingController3.view.bottomAnchor, constant: 50), // Position button below the label
            deleteAllCacheButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            deleteAllCacheButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        // Additional UI setup
        view.backgroundColor = .white
        
        // Add hosting controllers as child view controllers
        self.addChild(hostingController1)
        hostingController1.didMove(toParent: self)
        
        self.addChild(hostingController2)
        hostingController2.didMove(toParent: self)
       
       self.addChild(hostingController3)
       hostingController3.didMove(toParent: self)
    }
   
   @objc func launchRecipeDetails1() {
      let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "22509", openMyBasket: changeTabToMyBasket)
      if let nav = self.navigationController {
         nav.present(recipeDetails, animated: true)
      }
   }
   
   @objc func launchRecipeDetails2() {
      let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "14472", openMyBasket: changeTabToMyBasket)
      if let nav = self.navigationController {
         nav.present(recipeDetails, animated: true)
      }
   }
   
   func changeTabToMyBasket() {
      self.tabBarController?.selectedIndex = 1
      print("code ran")
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
