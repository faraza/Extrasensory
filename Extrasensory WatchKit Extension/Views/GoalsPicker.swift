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
    //If it's not urgePicker, then it's lapse picker
    var isUrgePicker: Bool
    
    
    var body: some View {

        let goalsList = goalsModel.goalsList.map{$0.shortName}

        Picker("", selection: $currentGoal){
            ForEach(goalsList, id: \.self){ goal in
                Text("\(goal)")
            }
        }
        .onChange(of: currentGoal, perform: {newGoal in
            goalsModel.setSelectedGoalFromName(goalName: currentGoal, fromUrgeView: isUrgePicker)
        })
        .frame(height: 50)        
    }
}

struct GoalsPicker_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsListModel()
    static var previews: some View {
            GoalsPicker(isUrgePicker: false)
                .environmentObject(goalsModel)
    }
}
