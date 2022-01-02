//
//  ExtrasensoryApp.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

@main
struct ExtrasensoryApp: App {
    
    var body: some Scene {
        WindowGroup {
            XSEventsListView(events: XSEvent.sampleData)
        }
    }
}
