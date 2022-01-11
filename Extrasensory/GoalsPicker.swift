//
//  GoalsPicker.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct GoalsPicker: View {
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: false)],
                  predicate: NSPredicate(format: "isActive == true"))
    private var goals: FetchedResults<Goal>
    
    @State private var selectedGoalModel = SelectedGoalModel.shared
    
    var body: some View {
        
        Picker("Goal", selection: $selectedGoalModel.goal){
            ForEach(goals, id: \.self){ goal in
                Text("\(goal.shortName ?? "NOSHORTNAMESET")")
            }
        }
        .pickerStyle(.wheel)
    }
}

class SelectedGoalModel: ObservableObject{
    static let shared = SelectedGoalModel()
    @Published var goal: Goal?
}

struct GoalsPicker_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()
    static var previews: some View {
        GoalsPicker()
            .environmentObject(goalsModel)
    }
}
