//
//  ContentView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            UrgeView()
            MoreButtonsView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
