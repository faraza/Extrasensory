//
//  GoalsList.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalsList: View {
    @State var goals: [String]
    
    func move(from source: IndexSet, to destination: Int) {
        goals.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(goals, id: \.self){ goal in
                    Text(goal)
                }
                .onMove(perform: move)
            }
            .toolbar{
                EditButton()
            }
        }
    }
}

struct GoalsList_Previews: PreviewProvider {
    static let goals = ["Biting Nails", "Browse", "Judgmental Thoughts"]
    static var previews: some View {
        GoalsList(goals: goals)
    }
}
