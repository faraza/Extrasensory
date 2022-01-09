//
//  GoalsList.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalsList: View {
    @State var activeGoals: [String]
    @State var inactiveGoals: [String]        
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Active Goals")){
                    ForEach(activeGoals, id: \.self){ goal in
                        Text(goal)
                    }
                    .onMove{source, destination in
                        activeGoals.move(fromOffsets: source, toOffset: destination)
                    }
                }
                Section(header: Text("Inactive Goals")){
                    ForEach(inactiveGoals, id: \.self){ goal in
                        Text(goal)
                    }
                    .onMove{source, destination in
                        inactiveGoals.move(fromOffsets: source, toOffset: destination)
                    }
                }
            }
            .toolbar{
                EditButton()
            }
        }
    }
}

struct GoalsList_Previews: PreviewProvider {
    static let activeGoals = ["Biting Nails", "Browse", "Judgmental Thoughts"]
    static let inactiveGoals = ["Video Games", "Karate"]
    static var previews: some View {
        GoalsList(activeGoals: activeGoals, inactiveGoals: inactiveGoals)
    }
}
