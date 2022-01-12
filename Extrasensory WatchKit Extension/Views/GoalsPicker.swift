//
//  ScrollableGoalsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct GoalsPicker: View {
    @EnvironmentObject var goalsModel: GoalsListModel
    @State var currentGoal: GoalRawData?
    
    
    var body: some View {
        let goalsList = goalsModel.goalsList //TODO: If picker doesn't update when goalsList changes, this is why

        Picker("", selection: $currentGoal){
            ForEach(goalsList, id: \.self){ goal in
                Text("\(goal.shortName)")
            }
        }
        .frame(height: 50)        
    }
}

struct GoalsPicker_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsListModel()
    static var previews: some View {
            GoalsPicker()
                .environmentObject(goalsModel)
    }
}
