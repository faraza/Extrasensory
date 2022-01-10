//
//  GoalsList.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalListView: View {
    
    @State private var activeGoals: [String]
    @State private var inactiveGoals: [String]
    
    init(_previewActiveGoals: [String]? = nil, _previewInactiveGoals: [String]? = nil){
        activeGoals = _previewActiveGoals ?? []
        inactiveGoals = _previewInactiveGoals ?? []
    }
    
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
                }
            }
            .toolbar{
                EditButton()
            }
        }
    }
}

struct GoalListView_Previews: PreviewProvider {
    static let activeGoals = ["Biting Nails", "Browse", "Judgmental Thoughts"]
    static let inactiveGoals = ["Video Games", "Karate"]
    static var previews: some View {
        GoalListView(_previewActiveGoals: activeGoals, _previewInactiveGoals: inactiveGoals)
    }
}
