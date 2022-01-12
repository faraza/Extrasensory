//
//  MoreButtonsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct MoreButtonsView: View {
    @EnvironmentObject var goalsModel: GoalsListModel
    @State var isLapseInProgress = false
    
    var body: some View {
        VStack{
            GoalsPicker()
            Button(action:{
            }){
                Text("Lapse")
                    .font(.title2)
                    .fontWeight(.thin)
                    .padding(.vertical, 40) //TODO: Don't hardcode the number - make it a % of screen size
            }
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                if(isLapseInProgress){
                    if let currentGoal = GoalsListModel.currentlySelectedGoal{
                        XSEventsTransmitter.eventButtonPressed(currentGoal: currentGoal.identifierKey, eventType: .lapseEnd)
                    }
                }
                else{
                    if let currentGoal = GoalsListModel.currentlySelectedGoal{
                        XSEventsTransmitter.eventButtonPressed(currentGoal: currentGoal.identifierKey, eventType: .lapseStart)
                    }
                }
                isLapseInProgress = !isLapseInProgress
            })
            .simultaneousGesture(TapGesture().onEnded {
                if let currentGoal = GoalsListModel.currentlySelectedGoal{
                    XSEventsTransmitter.eventButtonPressed(currentGoal: currentGoal.identifierKey, eventType: .atomicLapse)
                }
            })
            
        }
    }
}

struct MoreButtonsView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsListModel()

    static var previews: some View {
        MoreButtonsView()
            .environmentObject(goalsModel)
    }
}
