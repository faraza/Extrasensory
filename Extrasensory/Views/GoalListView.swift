//
//  GoalsList.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalListView: View {
    var _previewActiveGoals: [String]?
    var _previewInactiveGoals: [String]?
    
    @State private var activeGoals: [String] = []
    @State private var inactiveGoals: [String] = []
    @State private var editMode: EditMode = EditMode.inactive
        
    
    func onAdd(){
        //TODO
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
                    .onDelete(){ offsets in
                        for offset in offsets{
                            let eventToInactivate = activeGoals[offset]
                            //TODO: Set to inactive
//                            CoreDataStore.shared.saveContext()
                        }
                    }
                }
                Section(header: Text("Inactive Goals")){
                    ForEach(inactiveGoals, id: \.self){ goal in
                        Text(goal)
                    }
                    .onDelete(){ offsets in
                        for offset in offsets{
                            let eventToDelete = inactiveGoals[offset]
//                            managedObjectContext.delete(eventToDelete) //TODO
//                            CoreDataStore.shared.saveContext()
                        }
                    }
                }
            }
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $editMode)

        }
        
        .onAppear {
            activeGoals = _previewActiveGoals ?? activeGoals
            inactiveGoals = _previewInactiveGoals ?? inactiveGoals
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
