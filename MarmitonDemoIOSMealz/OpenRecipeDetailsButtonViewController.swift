//
//  OpenRecipeDetailsButtonViewController.swift
//  MarmitonDemoIOSMealz
//
//  Created by Diarmuid McGonagle on 04/04/2024.
//

import Foundation
import UIKit

class OpenRecipeDetailsButtonViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton(type: .system) // .system gives you the 'UIKit' look
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sample Recipe Details"
        label.textAlignment = .center
        
        // Configure the button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Launch", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Add the label and button to the view hierarchy
        view.addSubview(label)
        view.addSubview(button)
        
        // Constraints for the label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20), // Offset by -20 to make room for the button
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20), // Position button below the label
            button.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        // Additional UI setup
        view.backgroundColor = .white
    }
    
    @objc func buttonTapped() {
       // if they don't have a store:
       // launch store locator
       // else
       // launch Recipe Details
       let recipeDetails = RecipeDetailsViewController(recipeId: "15218")
       if let nav = self.navigationController {
          nav.present(recipeDetails, animated: true)
       }
    }
}

class RecipeDetailsViewController: UIViewController {
   
   let recipeId: String
   let changeStoreButton = UIButton(type: .system) // .system gives you the 'UIKit' look
   let recipeDetails: StandaloneRecipeDetailsViewController
   
   init(recipeId: String) {
      self.recipeId = recipeId
      self.recipeDetails = StandaloneRecipeDetailsViewController(recipeId: recipeId)
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the label
       changeStoreButton.translatesAutoresizingMaskIntoConstraints = false
       changeStoreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
       changeStoreButton.setTitle("Change Store", for: .normal)
       
       recipeDetails.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the label and button to the view hierarchy
       view.addSubview(changeStoreButton)
           addChild(recipeDetails) // Add recipeDetails as a child view controller
           view.addSubview(recipeDetails.view)
           recipeDetails.didMove(toParent: self)
        
        // Constraints for the label
       NSLayoutConstraint.activate([
               changeStoreButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
               changeStoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               changeStoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               changeStoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               changeStoreButton.heightAnchor.constraint(equalToConstant: 30) // Set the height to at least 50pt
           ])
           
           // Constraints for the recipeDetails.view
           NSLayoutConstraint.activate([
               recipeDetails.view.topAnchor.constraint(equalTo: changeStoreButton.bottomAnchor),
               recipeDetails.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               recipeDetails.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               recipeDetails.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ])
        
        // Additional UI setup
        view.backgroundColor = .white
    }
    
    @objc func buttonTapped() {
       // if they don't have a store:
       // launch store locator
       // else
       // launch Recipe Details
       let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "15218")
       if let nav = self.navigationController {
          nav.present(recipeDetails, animated: true)
       }
    }
}
