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
   
   let recipeDetailsLabel = UILabel()
   let recipeDetailsButton = UIButton(type: .system) // .system gives you the 'UIKit' look
   
   let changeStoreLabel = UILabel()
   let changeStoreToggle = UISwitch()
   
   let changeUserLabel = UILabel()
   let changeUserToggle = UISwitch()
   
   let priceOfRecipeButton = UIButton(type: .system)
   var priceOfRecipe: String? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      /* ----------------------------- RECIPE DETAILS -----------------------------------------------*/
      // Configure the label
      recipeDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsLabel.text = "Sample Recipe Details"
      recipeDetailsLabel.textAlignment = .center
      
      // Configure the button
      recipeDetailsButton.translatesAutoresizingMaskIntoConstraints = false
      recipeDetailsButton.setTitle("Launch", for: .normal)
      recipeDetailsButton.addTarget(self, action: #selector(launchRecipeDetails), for: .touchUpInside)
      
      /* ----------------------------- CHANGE STORE -----------------------------------------------*/
      // Configure the label
      changeStoreLabel.translatesAutoresizingMaskIntoConstraints = false
      changeStoreLabel.text = "Has Store"
      changeStoreLabel.textAlignment = .center
      
      // Configure the button
      changeStoreToggle.translatesAutoresizingMaskIntoConstraints = false
      changeStoreToggle.isOn = true
      
      // Add target to handle value change
      changeStoreToggle.addTarget(self, action: #selector(changeStoreChanged(_:)), for: .valueChanged)
      
      /* ----------------------------- CHANGE USER -----------------------------------------------*/
      // Configure the label
      changeUserLabel.translatesAutoresizingMaskIntoConstraints = false
      changeUserLabel.text = "Change User"
      changeUserLabel.textAlignment = .center
      
      // Configure the button
      changeUserToggle.translatesAutoresizingMaskIntoConstraints = false
      changeUserToggle.isOn = true
      
      // Add target to handle value change
      changeUserToggle.addTarget(self, action: #selector(changeUserChanged(_:)), for: .valueChanged)
      
      /* ----------------------------- PRICE OF RECIPE -----------------------------------------------*/
      // Configure the button
      priceOfRecipeButton.translatesAutoresizingMaskIntoConstraints = false
      priceOfRecipeButton.setTitle(priceOfRecipe ?? "Get Price", for: .normal)
      priceOfRecipeButton.addTarget(self, action: #selector(getPriceOrRedirect), for: .touchUpInside)
      
      // Add the label and button to the view hierarchy
      view.addSubview(recipeDetailsLabel)
      view.addSubview(recipeDetailsButton)
      view.addSubview(changeStoreLabel)
      view.addSubview(changeStoreToggle)
      view.addSubview(changeUserLabel)
      view.addSubview(changeUserToggle)
      view.addSubview(priceOfRecipeButton)
      
      // Constraints for the label
      NSLayoutConstraint.activate([
         recipeDetailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // 20 points from the top of the safe area
         recipeDetailsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      // Constraints for the button
      NSLayoutConstraint.activate([
         recipeDetailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         recipeDetailsButton.topAnchor.constraint(equalTo: recipeDetailsLabel.bottomAnchor, constant: 20), // Position button below the label
         recipeDetailsButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         recipeDetailsButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      NSLayoutConstraint.activate([
         changeStoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         changeStoreLabel.topAnchor.constraint(equalTo: recipeDetailsButton.bottomAnchor, constant: 20), // Position button below the label
         changeStoreLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         changeStoreLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      NSLayoutConstraint.activate([
         changeStoreToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         changeStoreToggle.topAnchor.constraint(equalTo: changeStoreLabel.bottomAnchor, constant: 20), // Position button below the label
         changeStoreToggle.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         changeStoreToggle.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         changeUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         changeUserLabel.topAnchor.constraint(equalTo: changeStoreToggle.bottomAnchor, constant: 20), // Position button below the label
         changeUserLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         changeUserLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      NSLayoutConstraint.activate([
         changeUserToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         changeUserToggle.topAnchor.constraint(equalTo: changeUserLabel.bottomAnchor, constant: 20), // Position button below the label
         changeUserToggle.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         changeUserToggle.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      NSLayoutConstraint.activate([
         priceOfRecipeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         priceOfRecipeButton.topAnchor.constraint(equalTo: changeUserToggle.bottomAnchor, constant: 20), // Position button below the label
         priceOfRecipeButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
         priceOfRecipeButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
      ])
      
      // Additional UI setup
      view.backgroundColor = .white
   }
   
   @objc func launchRecipeDetails() {
      // if they don't have a store:
      // launch store locator
      // else
      // launch Recipe Details
      let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "14472")
      if let nav = self.navigationController {
         nav.present(recipeDetails, animated: true)
      }
   }
   
   @objc func getPriceOrRedirect() {
      if priceOfRecipe == nil {
         Task {
            do {
               let price = try await Mealz.shared.recipe.getPriceOrRedirect(recipeId: "14472", numberOfGuest: 4).await()
               self.priceOfRecipe = String(price as? Double ?? 0)
               DispatchQueue.main.async { [weak self] in
                  self?.priceOfRecipeButton.setTitle(self?.priceOfRecipe ?? "Get Price", for: .normal)
               }
            } catch {
               DispatchQueue.main.async { [weak self] in
                  self?.priceOfRecipeButton.setTitle("Failed to get price", for: .normal)
               }
            }
         }
      }
   }
   
   @objc func changeStoreChanged(_ sender: UISwitch) {
      if sender.isOn {
         Mealz.shared.user.setStoreWithMealzId(storeId: "25910")
      } else { Mealz.shared.user.setStoreWithMealzId(storeId: "") }
   }
   
   @objc func changeUserChanged(_ sender: UISwitch) {
      if sender.isOn {
         Mealz.shared.user.updateUserId(userId: "test_\(UUID())", authorization: Authorization.userId)
      } else {
         Mealz.shared.user.updateUserId(userId: nil, authorization: Authorization.userId)
      }
   }
}
