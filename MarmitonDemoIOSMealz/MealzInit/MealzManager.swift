//
//  MiamManager.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 23/10/2023.
//

import Foundation
import mealzcore
import MealziOSSDK
import MealzUIiOSSDK
import MarmitonUIMealzIOS

public class MealzManager: ObservableObject {
    public static let sharedInstance = MealzManager()
    
    // need to be private
    private init() {
//        let supplierKeyUAT = "ewoJInN1cHBsaWVyX2lkIjogIjciLAoJInBsYXVzaWJsZV9kb21haW5lIjogIm1pYW0uY291cnNlc3UuYXBwIiwKCSJtaWFtX29yaWdpbiI6ICJjb3Vyc2VzdSIsCgkib3JpZ2luIjogIm1pYW0uY291cnNlc3UuYXBwIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlVBVCIKfQ"
        let supplierKey = "ewogICAgICAgICJwcm92aWRlcl9pZCI6ICJtYXJtaXRvbiIKCSJwbGF1c2libGVfZG9tYWluZSI6ICJtaWFtLm1hcm1pdG9uLmFwcCIsCgkibWlhbV9vcmlnaW4iOiAibWFybWl0b24iLAoJIm9yaWdpbiI6ICJtaWFtLm1hcm1pdG9uLmFwcCIsCgkibWlhbV9lbnZpcm9ubWVudCI6ICJVQVQiCn0="
        
        I18nResolver.shared.registerAppBundle(bundle: MarmitonUIMealzIOS.bundle)
        
        let demoBasketService = DemoBasketService(initialBasketList: PretendBasket.shared.items)
        
        Mealz.shared.Core(
            init: { coreBuilder in
            // set supplier key
            coreBuilder.sdkRequirement(init: { requirementBuilder in
                requirementBuilder.key = supplierKey
            })
                coreBuilder.option(init: { config in
                    config.isAnonymousModeEnabled = true
                })
            // set listeners & notifiers
            coreBuilder.subscriptions(init:  { subscriptionBuilder in
                subscriptionBuilder.basket(init: { basketSubscriptionBuilder in
                    // subscribe
                    basketSubscriptionBuilder.subscribe(subscriber: demoBasketService)
                    // push updates
                    basketSubscriptionBuilder.register(publisher: demoBasketService)
                })
            })
        })
        // set store
        Mealz.shared.user.setStoreWithMealzId(storeId: "25910")
        // set userID
        Mealz.shared.user.updateUserId(userId: "test_\(UUID())", authorization: Authorization.userId)
        // allow profiling -> can we use your personal data to provide custom recipes?
        Mealz.shared.user.setProfilingAllowance(allowance: true)
        // allow users to heart recipes
        Mealz.shared.user.setEnableLike(isEnable: true)
        // show toast to users on certain events
        Mealz.shared.notifications.toaster.listen(callBack: { event in
            switch event as? ToasterNotification {
            case ToasterNotification.RecipeAdded():
                LogHandler.companion.info("MealzNotification: Recipe Added")
            case ToasterNotification.RecipeLiked():
                LogHandler.companion.info("MealzNotification: Recipe Liked")
            default:
                break
            }
        })
        // listen to analytics events
        Mealz.shared.notifications.analytics.listen { event in
            print("Mealz.Notifications.analytics \(String(describing: event))")
        }
        
        // show "Sponsored" tag on products that are sponsored
        Mealz.shared.environment.setAllowsSponsoredProducts(isAllowed: true)
        
        // set the redirection when the user has not selected a store
        Mealz.shared.user.setStoreLocatorRedirection { changeStore() }
        
        // set how many logs you want:
        // .errorsAndWarns, .errorsOnly, .allLogs, or .noLogs
        // default is .errorsAndWarns
        LogHandler.companion.logLevel = .allLogs
        
        configDimensions()
    }
}
