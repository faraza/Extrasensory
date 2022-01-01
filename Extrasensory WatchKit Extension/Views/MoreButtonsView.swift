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
            ScrollableGoalsView()
            Button(action:{
                //TODO: Call model
                isLapseInProgress = !isLapseInProgress
            }){
                if(isLapseInProgress){
                    Text("Lapse End")
                }
                else{
                    Text("Lapse Start")
                }
                
            }
            Button(action: {}){
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
