//
//  GoalsList.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalListView: View {
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: true)],
                  predicate: NSPredicate(format: "isActive == true"))
    private var activeGoals: FetchedResults<Goal>
    
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: true)],
                  predicate: NSPredicate(format: "isActive == false"))
    private var inactiveGoals: FetchedResults<Goal>
    
//    var _previewActiveGoals: [String]?
//    var _previewInactiveGoals: [String]?
    
//    @State private var activeGoals: [Goal] = []
//    @State private var inactiveGoals: [Goal] = []
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
                            NavigationLink(destination: GoalDetailView(existingGoalEntity: goal)){ //TODO: Include param
                                Text(goal.shortName ?? "NO SHORTNAME")
                            }
                        }
                        .onMove{source, destination in
//                            activeGoals.move(fromOffsets: source, toOffset: destination)
                            //TODO: Swap indices
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
                            NavigationLink(destination: GoalDetailView(existingGoalEntity: goal)){ //TODO: pass param
                                Text(goal.shortName ?? "NO SHORTNAME")
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
//            activeGoals = _previewActiveGoals ?? activeGoals
//            inactiveGoals = _previewInactiveGoals ?? inactiveGoals
            
            //TODO: Sort goals first (?)
        }
    }
}

struct GoalListView_Previews: PreviewProvider {
    static let activeGoals = ["Biting Nails", "Browse", "Judgmental Thoughts"]
    static let inactiveGoals = ["Video Games", "Karate"]
    static var previews: some View {
        GoalListView()
//        GoalListView(_previewActiveGoals: activeGoals, _previewInactiveGoals: inactiveGoals)
    }
}
