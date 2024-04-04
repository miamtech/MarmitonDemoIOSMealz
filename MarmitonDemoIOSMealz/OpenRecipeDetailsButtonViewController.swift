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
       let recipeDetails = StandaloneRecipeDetailsViewController(recipeId: "15218")
       if let nav = self.navigationController {
          nav.present(recipeDetails, animated: true)
       }
    }
}
