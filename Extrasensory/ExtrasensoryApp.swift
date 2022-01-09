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
    let session = WCSessionManager()
    let context = CoreDataStore.shared.persistentContainer.viewContext
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .onAppear{
                XSEventsStore.load { result in //TODO: Delete this after migration
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let events):
                        print("successfully loaded via filemanager. Length: \(events.count)")
                        XSEventsStore.events = events
                    }
                }
            }
            .environment(\.managedObjectContext, context)
        }
    }
}
