//
//  AppDelegate.swift
//  HandicapCalculator
//
//  Created by Артём on 19.09.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.shared.saveContext()
    }
}
