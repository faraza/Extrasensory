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
    
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: false)],
                  predicate: NSPredicate(format: "isActive == false"))
    private var inactiveGoals: FetchedResults<Goal>
    
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
                            NavigationLink(destination: GoalDetailView(existingGoalEntity: goal)){
                                Text((goal.shortName ?? "NO SHORTNAME") + String(goal.activeListPosition))                                
                            }
                        }
                        .onMove{sourceIndexSet, destinationOffset in
                            for sourceIndex in sourceIndexSet{
                                GoalCDInterface.shared.moveGoalToOffset(goalIndex: sourceIndex, offset: destinationOffset)
                            }
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let goalToDeactivate = activeGoals[offset]
                                GoalCDInterface.shared.updateGoal(goalEntity: goalToDeactivate, isActiveGoal: false)
                            }
                        }
                    }
                    Section(header: Text("Inactive Goals")){
                        ForEach(inactiveGoals, id: \.self){ goal in
                            NavigationLink(destination: GoalDetailView(existingGoalEntity: goal)){
                                Text(goal.shortName ?? "NO SHORTNAME")
                            }
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let goalToDelete = inactiveGoals[offset]
                                //TODO
                                let _ = GoalCDInterface.shared.deleteGoal(goalEntity: goalToDelete)
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
            //TODO: Sort goals first (?)
        }
    }
}

struct GoalListView_Previews: PreviewProvider {
    static let activeGoals = ["Biting Nails", "Browse", "Judgmental Thoughts"]
    static let inactiveGoals = ["Video Games", "Karate"]
    static var previews: some View {
        GoalListView() //TODO: Get it working with preview list again
        //        GoalListView(_previewActiveGoals: activeGoals, _previewInactiveGoals: inactiveGoals)
    }
}
