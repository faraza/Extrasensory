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
            .environment(\.managedObjectContext, context)
        }
    }
}
