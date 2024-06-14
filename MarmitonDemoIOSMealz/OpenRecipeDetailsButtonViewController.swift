//
//  OpenRecipeDetailsButtonViewController.swift
//  MarmitonDemoIOSMealz
//
//  Created by Diarmuid McGonagle on 04/04/2024.
//

import Foundation
import UIKit
import mealzcore

class OpenRecipeDetailsButtonViewController: UIViewController {
   
   let recipeDetailsLabel1 = UILabel()
   let recipeDetailsButton1 = UIButton(type: .system)
   
   let priceOfRecipeButton1 = UIButton(type: .system)
   var priceOfRecipe1: String? = nil
   
   let recipeDetailsLabel2 = UILabel()
   let recipeDetailsButton2 = UIButton(type: .system)
   
   let priceOfRecipeButton2 = UIButton(type: .system)
   var priceOfRecipe2: String? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      /* ----------------------------- RECIPE DETAILS 1 -----------------------------------------------*/
      // Configure the label
      recipeDetailsLabel1.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsLabel1.text = "Sample Recipe 1"
      recipeDetailsLabel1.textAlignment = .center
      
      // Configure the button
      recipeDetailsButton1.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsButton1.setTitle("Launch", for: .normal)
      recipeDetailsButton1.addTarget(self, action: #selector(launchRecipeDetails1), for: .touchUpInside)
      
      // Configure the button
      priceOfRecipeButton1.translatesAutoresizingMaskIntoConstraints = false
      priceOfRecipeButton1.setTitle(priceOfRecipe1 ?? "Get Price", for: .normal)
      priceOfRecipeButton1.addTarget(self, action: #selector(getPriceOrRedirect1), for: .touchUpInside)
      
      /* ----------------------------- RECIPE DETAILS 2 -----------------------------------------------*/
      // Configure the label
      recipeDetailsLabel2.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsLabel2.text = "Sample Recipe 2"
      recipeDetailsLabel2.textAlignment = .center
      
      // Configure the button
      recipeDetailsButton2.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsButton2.setTitle("Launch", for: .normal)
      recipeDetailsButton2.addTarget(self, action: #selector(launchRecipeDetails2), for: .touchUpInside)
      
      // Configure the button
      priceOfRecipeButton2.translatesAutoresizingMaskIntoConstraints = false
      priceOfRecipeButton2.setTitle(priceOfRecipe2 ?? "Get Price", for: .normal)
      priceOfRecipeButton2.addTarget(self, action: #selector(getPriceOrRedirect2), for: .touchUpInside)
      
      // Add the label and button to the view hierarchy
      view.addSubview(recipeDetailsLabel1)
      view.addSubview(recipeDetailsButton1)
      view.addSubview(priceOfRecipeButton1)
      view.addSubview(recipeDetailsLabel2)
      view.addSubview(recipeDetailsButton2)
      view.addSubview(priceOfRecipeButton2)
      
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
      
      NSLayoutConstraint.activate([
         priceOfRecipeButton1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         priceOfRecipeButton1.topAnchor.constraint(equalTo: recipeDetailsButton1.bottomAnchor, constant: 20), // Position button below the label
         priceOfRecipeButton1.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         priceOfRecipeButton1.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         recipeDetailsLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsLabel2.topAnchor.constraint(equalTo: priceOfRecipeButton1.bottomAnchor, constant: 20), // Position button below the label
         recipeDetailsLabel2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsLabel2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         recipeDetailsButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsButton2.topAnchor.constraint(equalTo: recipeDetailsLabel2.bottomAnchor, constant: 20), // Position button below the label
         recipeDetailsButton2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsButton2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         priceOfRecipeButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         priceOfRecipeButton2.topAnchor.constraint(equalTo: recipeDetailsButton2.bottomAnchor, constant: 20), // Position button below the label
         priceOfRecipeButton2.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         priceOfRecipeButton2.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      // Additional UI setup
      view.backgroundColor = .white
   }
   
   @objc func launchRecipeDetails1() {
      let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "22509")
      if let nav = self.navigationController {
         nav.present(recipeDetails, animated: true)
      }
   }
   
   @objc func launchRecipeDetails2() {
      let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "14472")
      if let nav = self.navigationController {
         nav.present(recipeDetails, animated: true)
      }
   }
   
   @objc func getPriceOrRedirect1() {
      if priceOfRecipe1 == nil {
         Task {
            do {
               let price = try await Mealz.shared.recipe.getPriceOrRedirect(recipeId: "22509", numberOfGuest: 4).await()
               let priceOfRecipe = price as? Double ?? 0
               if priceOfRecipe == 0.0 { return }
               self.priceOfRecipe1 = String(priceOfRecipe)
               DispatchQueue.main.async { [weak self] in
                  self?.priceOfRecipeButton1.setTitle(self?.priceOfRecipe1 ?? "Get Price", for: .normal)
               }
            } catch {
               DispatchQueue.main.async { [weak self] in
                  self?.priceOfRecipeButton1.setTitle("Failed to get price", for: .normal)
               }
            }
         }
      }
   }
   
   @objc func getPriceOrRedirect2() {
      if priceOfRecipe2 == nil {
         Task {
            do {
               let price = try await Mealz.shared.recipe.getPriceOrRedirect(recipeId: "14472", numberOfGuest: 4).await()
               let priceOfRecipe = price as? Double ?? 0
               if priceOfRecipe == 0.0 { return }
               self.priceOfRecipe1 = String(priceOfRecipe)
               DispatchQueue.main.async { [weak self] in
                  self?.priceOfRecipeButton2.setTitle(self?.priceOfRecipe2 ?? "Get Price", for: .normal)
               }
            } catch {
               DispatchQueue.main.async { [weak self] in
                  self?.priceOfRecipeButton2.setTitle("Failed to get price", for: .normal)
               }
            }
         }
      }
   }
}
