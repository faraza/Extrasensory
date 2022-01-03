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
            }){
                Text("Urge")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.vertical, 40) //TODO: Don't hardcode the number - make it a % of screen size
            }
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .dangerZone)
            })
            .simultaneousGesture(TapGesture().onEnded {
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .urge)
            })
            
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
