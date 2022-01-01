//
//  ContentView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Nail Biting")
            Button(action: {}){
                Text("Lapse Start")
            }
            Button(action: {}){
                Text("Urge")
            }
            Button(action: {}){
                Text("Lapse End")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
