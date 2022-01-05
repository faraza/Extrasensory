//
//  ExtrasensoryApp.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

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
        }
    }
}
