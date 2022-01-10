//
//  GoalCDInterface.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import Foundation

/**
 Interface with core data.
 
 This is necessary because of re-indexing. There are two lists of goal entities - active and inactive.
 The position of the inactive list doesn't matter, but the position of the active one does - that's the order in which the user will see the items,
 and is manually set by them.
 Core data doesn't cleanly support this out of the box, so we have an index variable that gets recalculated for everyone once the list is updated.
 */
class GoalCDInterface{
    static let shared = GoalCDInterface()
        
    
    func addGoal(goalName: String, goalDescription: String = "", isActiveGoal: Bool){
        let newGoalEntity = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        newGoalEntity.shortName = goalName
        newGoalEntity.longDescription = goalDescription
        newGoalEntity.isActive = isActiveGoal
        newGoalEntity.identifierKey = String(Int(Date().timeIntervalSince1970) + Int.random(in: 0...1000000000))
        //TODO: Fetch all active goals. Position = activeGoals.length
                
        CoreDataStore.shared.saveContext()
    }
    
    /**
     Goal will not delete if there are events that reference its key
     */
    func deleteGoal(goalEntity: Goal)->Bool{
        //TODO: If events reference the goal key, return false
        CoreDataStore.shared.persistentContainer.viewContext.delete(goalEntity)
        CoreDataStore.shared.saveContext()
        return true
    }
    
    func updateGoal(goalEntity: Goal, goalDescription: String? = nil, isActiveGoal: Bool){
        let becameActive = (isActiveGoal && !goalEntity.isActive)
                        
        if let unwrapped = goalDescription {goalEntity.longDescription = unwrapped}
        goalEntity.isActive = isActiveGoal
        if(becameActive){
            //TODO: Fetch all active goals. Position = activeGoals.length
        }
        else{
            reindex()
        }
        CoreDataStore.shared.saveContext()
    }
    
    /**
            I'd rather do the swap logic in this class, but it requires weird stuff with offsets that are
                a lot simpler to just do in the list class
     */
    func confirmPositionSwap(){
        
    }
    
    func swapPositionsInActiveList(firstGoal: Goal, secondGoal: Goal){
        guard (firstGoal.isActive) else {return}
        guard (secondGoal.isActive) else {return}
        
        let position1 = firstGoal.activeListPosition
        let position2 = secondGoal.activeListPosition
        
        firstGoal.activeListPosition = position2
        secondGoal.activeListPosition = position1
        CoreDataStore.shared.saveContext()
    }
    
    private func reindex(){
        //TODO
    }
}
