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
    @StateObject private var store = XSEventsStore()
    var session = WCSessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(events: $store.events)
            .onAppear{
                XSEventsStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let events):
                        store.events = events
                    }
                }
            }
            .environment(\.managedObjectContext, modelContainer.viewContext)
        }
    }
    
    var modelContainer: NSPersistentContainer = {
        let modelContainer = NSPersistentContainer(name: "Model")
        modelContainer.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Loading error: \(error), \(error.userInfo)")
            }
        })
        return modelContainer
    }()
}
