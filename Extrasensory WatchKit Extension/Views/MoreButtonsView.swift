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
                if(isLapseInProgress){
                    Text("Lapse End")
                        .font(.title2)
                        .fontWeight(.thin)
                        .padding(.vertical, 40) //TODO: Don't hardcode the number - make it a % of screen size
                }
                else{
                    Text("Lapse Start")
                        .font(.title2)
                        .fontWeight(.thin)
                        .padding(.vertical, 40) //TODO: Don't hardcode the number - make it a % of screen size
                }                
            }
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .atomicLapse)                
            })
            .simultaneousGesture(TapGesture().onEnded {
                if(isLapseInProgress){
                    XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .lapseEnd)
                }
                else{
                    
                    XSEventsTransmitter.eventButtonPressed(currentGoal: goalsModel.currentGoal, eventType: .lapseStart)
                }
                isLapseInProgress = !isLapseInProgress
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
