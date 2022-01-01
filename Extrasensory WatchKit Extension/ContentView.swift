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
            VStack{
                Text("Nail Biting")
                Button(action: {}){
                    Text("Urge")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .padding(.vertical, 30) //TODO: Don't hardcode the number
                }
                
                
            }
            Text("Sup")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
