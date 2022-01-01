//
//  UrgeView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct UrgeView: View {
    @EnvironmentObject var goalsModel: GoalsModel
    var body: some View {
        VStack{
            ScrollableGoalsView()
            
            Button(action: {
                XSEventsTransmitter.urgePressed(currentGoal: "Blah") //TODO
            }){
                Text("Urge")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.vertical, 30) //TODO: Don't hardcode the number
            }
   
        }
    }
}

struct UrgeView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()

    static var previews: some View {
        UrgeView()
            .environmentObject(goalsModel)
    }
}