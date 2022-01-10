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
    
    @State private var addGoalNavAction: Int? = 0
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(EmptyView())
        default:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        }
    }
    
    func onAdd(){
        self.addGoalNavAction = 1
    }
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: GoalDetailView(), tag: 1, selection: $addGoalNavAction){
                    EmptyView()
                }
                List{
                    Section(header: Text("Active Goals")){
                        ForEach(activeGoals, id: \.self){ goal in
                            NavigationLink(destination: GoalDetailView()){ //TODO: Include param
                                Text(goal)
                            }
                        }
                        .onMove{source, destination in
                            activeGoals.move(fromOffsets: source, toOffset: destination)
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let _ = activeGoals[offset]
                                //TODO: Set the event to inactive
                                //                            CoreDataStore.shared.saveContext()
                            }
                        }
                    }
                    Section(header: Text("Inactive Goals")){
                        ForEach(inactiveGoals, id: \.self){ goal in
                            NavigationLink(destination: GoalDetailView()){ //TODO: pass param
                                Text(goal)
                            }
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let _ = inactiveGoals[offset]
                                //                            managedObjectContext.delete(eventToDelete) //TODO
                                //                            CoreDataStore.shared.saveContext()
                            }
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        withAnimation{
                            if(editMode == .inactive){
                                editMode = .active
                            }
                            else{
                                editMode = .inactive
                            }
                        }
                    }) {
                        Text((editMode == .active) ? "Done" : "Edit")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    addButton
                }
                
            }
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
