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
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .urge)
            }){
                Text("Urge")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.vertical, 40) //TODO: Don't hardcode the number
            }
            .onTapGesture {
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .redZone)
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
