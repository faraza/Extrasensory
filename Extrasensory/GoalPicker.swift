//
//  GoalPicker.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct GoalPicker: View {
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: false)],
                  predicate: NSPredicate(format: "isActive == true"))
    private var goals: FetchedResults<Goal>
    
    @Binding var selectedGoal: Goal?
    
    var body: some View {
        
        Picker("Goal", selection: $selectedGoal){
            ForEach(goals, id: \.self){ goal in
                Text("\(goal.shortName ?? "NOSHORTNAMESET")").tag(goal as Goal?)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct GoalPicker_Previews: PreviewProvider {
    @State static var selectedGoal: Goal? = Goal()
    static var previews: some View {
        GoalPicker(selectedGoal: $selectedGoal)
    }
}
