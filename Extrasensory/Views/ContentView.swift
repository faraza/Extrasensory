//
//  ContentView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct ContentView: View{
    init(){
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
            GoalsListView()
                .tabItem{
                    Image(systemName: "brain.head.profile")
                    Text("Goals")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView()
    }
}
