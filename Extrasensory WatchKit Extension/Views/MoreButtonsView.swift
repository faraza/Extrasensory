//
//  MoreButtonsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct MoreButtonsView: View {
    @EnvironmentObject var goalsModel: GoalsModel
    @State var isLapseInProgress = false
    
    var body: some View {
        VStack{
            GoalsPicker()
            Button(action:{
                if(isLapseInProgress){
                    XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .lapseEnd)
                }
                else{
                    
                    XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .lapseStart)
                }
                isLapseInProgress = !isLapseInProgress
            }){
                if(isLapseInProgress){
                    Text("Lapse End")
                }
                else{
                    Text("Lapse Start")
                }
                
            }
            Button(action: {
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .atomicLapse)
            }){
                Text("Atomic Lapse")
            }
        }
    }
}

struct MoreButtonsView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()

    static var previews: some View {
        MoreButtonsView()
            .environmentObject(goalsModel)
    }
}
