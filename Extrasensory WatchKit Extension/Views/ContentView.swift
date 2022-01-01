//
//  ContentView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var goalsModel = GoalsModel()
    
    var body: some View {
        TabView{
            UrgeView()
            MoreButtonsView()
        }.environmentObject(goalsModel)
        
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView()
    }
}
