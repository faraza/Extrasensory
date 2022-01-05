//
//  ContentView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct ContentView: View{
    @Binding var events: [XSEvent]
    
    var body: some View{
        XSEventsListView(events: $events)
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var events = XSEvent.sampleData
    static var previews: some View {
        ContentView(events: $events)
    }
}
