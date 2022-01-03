//
//  ScrollableGoalsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct ScrollableGoalsView: View {
    @EnvironmentObject var goalsModel: GoalsModel
    
    
    var body: some View {
        let goalsList = goalsModel.goalsList //TODO: If picker doesn't update when goalsList changes, this is why

        Picker("", selection: $goalsModel.currentGoal){
            ForEach(goalsList, id: \.self){ goal in
                Text("\(goal)")
            }
        }
    }
}

struct ScrollableGoalsView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()
    static var previews: some View {
            ScrollableGoalsView()
                .environmentObject(goalsModel)
    }
}
