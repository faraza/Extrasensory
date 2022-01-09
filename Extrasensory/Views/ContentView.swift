//
//  ContentView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct ContentView: View{
    @Binding var events: [XSEventRawData]
    
    init(events: Binding <[XSEventRawData]>){
        self._events = events
        if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
    }
    
    var body: some View{
        TabView{
            XSEventLoggerView()
                .tabItem{
                    Image(systemName: "square.and.pencil")
                    Text("Log")
                }
            XSEventsListView()
                .tabItem{
                    Image(systemName: "book")
                    Text("Events")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var events = XSEventRawData.sampleData
    static var previews: some View {
        ContentView(events: $events)
    }
}
