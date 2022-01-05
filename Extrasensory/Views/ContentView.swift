//
//  ContentView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct ContentView: View{
    @Binding var events: [XSEvent]
    
    init(events: Binding <[XSEvent]>){
        self._events = events
        if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
    }
    
    var body: some View{
        TabView{
            XSEventLoggerView(events: $events)
                .tabItem{
                    Image(systemName: "square.and.pencil")
                    Text("Log")
                }
            XSEventsListView(events: $events)
                .tabItem{
                    Image(systemName: "book")
                    Text("Events")
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
