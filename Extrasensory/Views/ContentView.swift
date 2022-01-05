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
        TabView{
            XSEventsListView(events: $events)
                .tabItem{
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            XSEventLoggerView()
                .tabItem{
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var events = XSEvent.sampleData
    static var previews: some View {
        ContentView(events: $events)
    }
}
