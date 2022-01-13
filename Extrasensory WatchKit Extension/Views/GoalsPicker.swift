//
//  ScrollableGoalsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct GoalsPicker: View {
    @EnvironmentObject var goalsModel: GoalsListModel
    @State var currentGoal = ""
    var isUrgePicker = false
    
    
    var body: some View {

        let goalsList = goalsModel.goalsList.map{$0.shortName}

        Picker("", selection: $currentGoal){
            ForEach(goalsList, id: \.self){ goal in
                Text("\(goal)")
            }
        }
        .onChange(of: currentGoal, perform: {newGoal in
            print("Goal changed: \(newGoal)")
        })
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
