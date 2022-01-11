//
//  ExtrasensoryApp.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI
import CoreData

@main
struct ExtrasensoryApp: App {
    let session = WCSessionPhoneManager()
    let context = CoreDataStore.shared.persistentContainer.viewContext
    let goalCDInterface = GoalCDInterface.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()            
            .environment(\.managedObjectContext, context)
            .onAppear{
                performSetupIfFirstRun()
            }
        }
    }
    
    func performSetupIfFirstRun(){
        let appHasRunKey = "appHasRunBefore"
        let appHasRunBefore = UserDefaults.standard.bool(forKey: appHasRunKey)
        if(!appHasRunBefore){
            GoalCDInterface.populateOnFirstRun()
            UserDefaults.standard.set(true, forKey: appHasRunKey)
        }
    }
}
