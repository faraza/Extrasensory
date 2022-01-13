//
//  UrgeView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct UrgeView: View {
    @EnvironmentObject var goalsModel: GoalsListModel
    var body: some View {
        VStack{
            GoalsPicker()                
            
            Button(action: {
            }){
                Text("Urge")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.vertical, 40) //TODO: Don't hardcode the number - make it a % of screen size
            }
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                if let currentGoal = GoalsListModel.currentUrgeGoal{
                    XSEventsTransmitter.eventButtonPressed(currentGoal: currentGoal.identifierKey, eventType: .dangerZone)
                }
            })
            .simultaneousGesture(TapGesture().onEnded {
                if let currentGoal = GoalsListModel.currentUrgeGoal{
                    XSEventsTransmitter.eventButtonPressed(currentGoal: currentGoal.identifierKey, eventType: .urge)
                }
            })
            
        }
    }
}

struct UrgeView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsListModel()

    static var previews: some View {
        UrgeView()
            .environmentObject(goalsModel)
    }
}
