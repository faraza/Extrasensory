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
            }){
                Text("Lapse")
                    .font(.title2)
                    .fontWeight(.thin)
                    .padding(.vertical, 40) //TODO: Don't hardcode the number - make it a % of screen size
            }
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                if(isLapseInProgress){
                    XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .lapseEnd)
                }
                else{                    
                    XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .lapseStart)
                }
                isLapseInProgress = !isLapseInProgress
            })
            .simultaneousGesture(TapGesture().onEnded {
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .atomicLapse)
            })
            
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
