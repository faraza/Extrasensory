//
//  GoalCDInterface.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import Foundation
import CoreData

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
        newGoalEntity.identifierKey = String(Int(Date().timeIntervalSince1970) + Int.random(in: 0...1000000000))
        newGoalEntity.activeListPosition = Int16(getActiveGoalsLength())
        newGoalEntity.isActive = isActiveGoal
        CoreDataStore.shared.saveContext()
    }
    
    private func fetchActiveGoals()->[Goal]?{
        let fetchAllActiveGoals = Goal.fetchRequest()
        fetchAllActiveGoals.predicate = NSPredicate(format: "isActive == true")
        do{
            let activeGoalsList = try CoreDataStore.shared.persistentContainer.viewContext.fetch(fetchAllActiveGoals)
            return activeGoalsList
        }
        catch{
            print("Failed to fetch active goals list")
            return nil
        }
    }
    
    private func getActiveGoalsLength()->Int{ //TODO: Refactor to follow DRY
        let fetchAllActiveGoals = Goal.fetchRequest()
        fetchAllActiveGoals.predicate = NSPredicate(format: "isActive == true")
        do{
            let activeGoalsList = try CoreDataStore.shared.persistentContainer.viewContext.fetch(fetchAllActiveGoals)
            return activeGoalsList.count
        }
        catch{
            print("Failed to fetch active goals list")
            return 0
        }
    }
    
    /**
     Goal will not delete if there are events that reference its key
     */
    func deleteGoal(goalEntity: Goal)->Bool{
        let fetchRequest = XSEvent.fetchRequest()
        fetchRequest.fetchLimit = 1
        //TODO: If events reference the goal key, return false
        CoreDataStore.shared.persistentContainer.viewContext.delete(goalEntity)
        reindex()
        CoreDataStore.shared.saveContext()
        return true
    }
    
    func updateGoal(goalEntity: Goal, goalDescription: String? = nil, isActiveGoal: Bool){
        let becameActive = (isActiveGoal && !goalEntity.isActive)
        
        if let unwrapped = goalDescription {goalEntity.longDescription = unwrapped}
        if(becameActive){
            goalEntity.activeListPosition = Int16(getActiveGoalsLength())
        }
        goalEntity.isActive = isActiveGoal
        reindex()
        CoreDataStore.shared.saveContext()
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
        let activeGoals = fetchActiveGoals()
        if var unwrapped = activeGoals{
            unwrapped.sort{$0.activeListPosition < $1.activeListPosition}
            for i in 0 ... (unwrapped.count - 1){
                unwrapped[i].activeListPosition = Int16(i)
            }
        }
    }
}
