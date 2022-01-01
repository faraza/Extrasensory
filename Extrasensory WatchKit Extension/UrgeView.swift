//
//  UrgeView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct UrgeView: View {
    @State var goalIndex: Double = 0

    var body: some View {
        VStack{
            Text("Scroll: \(goalIndex)")
                .focusable(true)
                .digitalCrownRotation($goalIndex, from: 0, through: 5, by: 1, sensitivity: .low, isContinuous: true) //TODO: Use WKInterfacePicker later
            
            Button(action: {}){
                Text("Urge")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.vertical, 30) //TODO: Don't hardcode the number
            }
   
        }
    }
}

struct UrgeView_Previews: PreviewProvider {
    static var previews: some View {
        UrgeView()
    }
}
