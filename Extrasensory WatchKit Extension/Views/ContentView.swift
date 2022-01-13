//
//  ContentView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var goalsModel = GoalsListModel()
    
    var body: some View {
        TabView{
            UrgeView()
            MoreButtonsView()
        }.environmentObject(goalsModel)
            .onAppear{
                if let unwrapped = WCSessionWatchManager.session{
                    unwrapped.sendMessage([SessionDelegate.MessageKeys.requestAppContext.rawValue : true], replyHandler: nil) { (error) in
                    }
                }
            }        
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView()
    }
}
