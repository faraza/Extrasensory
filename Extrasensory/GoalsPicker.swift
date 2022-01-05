//
//  GoalsPicker.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct GoalsPicker: View {
    @EnvironmentObject var goalsModel: GoalsModel
    
    
    var body: some View {
        let goalsList = goalsModel.goalsList //TODO: If picker doesn't update when goalsList changes, this is why
        
        Picker("Goal", selection: $goalsModel.currentGoal){
            ForEach(goalsList, id: \.self){ goal in
                Text("\(goal)")
            }
        }
        .pickerStyle(.wheel)
    }
}

struct GoalsPicker_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()
    static var previews: some View {
        GoalsPicker()
            .environmentObject(goalsModel)
    }
}
