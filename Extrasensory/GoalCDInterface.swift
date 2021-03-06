//
//  GoalCDInterface.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import Foundation
import CoreData
import SwiftUI
/**
 Interface with core data.
 
 This is necessary because of re-indexing. There are two lists of goal entities - active and inactive.
 The position of the inactive list doesn't matter, but the position of the active one does - that's the order in which the user will see the items,
 and is manually set by them.
 Core data doesn't cleanly support this out of the box, so we have an index variable that gets recalculated for everyone once the list is updated.
 */
class GoalCDInterface{
    static let shared = GoalCDInterface()
    
    init(){
        transmitUpdatedGoalList()
    }
    
    func addGoal(goalName: String, goalDescription: String = "", isActiveGoal: Bool){
        let newGoalEntity = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        newGoalEntity.shortName = goalName
        newGoalEntity.longDescription = goalDescription
        newGoalEntity.identifierKey = String((Date().timeIntervalSince1970) + Double(Int.random(in: 0...1000000000)))
        newGoalEntity.activeListPosition = Int16(getActiveGoalsLength())
        newGoalEntity.isActive = isActiveGoal
        CoreDataStore.shared.saveContext()
        transmitUpdatedGoalList()
    }
    
    /**
     Goal will not delete if there are events that reference its key
     */
    func deleteGoal(goalEntity: Goal)->Bool{
        do{
            if let goalKey = goalEntity.identifierKey {
                let fetchRequest = XSEvent.fetchRequest()
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "goalKey == %@", goalKey)

                let eventList = try CoreDataStore.shared.persistentContainer.viewContext.fetch(fetchRequest)
                if (eventList.count > 0){ return false}
            }
        }
        catch{
            print("Failed to fetch single goal for deletion. Note - this doesn't there were no goals. Just that fetch didn't work.")
            return false
        }
        CoreDataStore.shared.persistentContainer.viewContext.delete(goalEntity)
        reindex()
        CoreDataStore.shared.saveContext()
        transmitUpdatedGoalList()
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
        transmitUpdatedGoalList()
    }

    func moveGoalToOffset(goalIndex: Int, offset: Int){
        var activeGoals = fetchActiveGoals()
        guard(activeGoals != nil) else {return}
                
        guard (activeGoals![goalIndex].isActive) else {return}
        
        activeGoals!.sort{$0.activeListPosition < $1.activeListPosition}

        if(goalIndex == (offset - 1) || goalIndex == offset){
            return
        }
        else if(goalIndex < offset - 1){
            for i in Int(goalIndex) + 1...Int(offset) - 1{
                activeGoals![Int(i)].activeListPosition -= 1
            }
            activeGoals![goalIndex].activeListPosition = Int16(offset - 1)
        }
        else{
            for i in offset...goalIndex{
                activeGoals![Int(i)].activeListPosition += 1
            }
            activeGoals![goalIndex].activeListPosition = Int16(offset)
        }
        
        reindex()
        CoreDataStore.shared.saveContext()
        transmitUpdatedGoalList()
    }
}

extension GoalCDInterface{
    static func getGoalNameFromKey(goalKey: String? = nil, goalsList: FetchedResults<Goal>)->String{
        if let unwrappedKey = goalKey{
            return goalsList.first(where: {
                $0.identifierKey == unwrappedKey
            })?.shortName ?? "GOAL NAME NOT FOUND"
        }
        
        return "GOAL NAME NOT FOUND"
    }
}

extension GoalCDInterface{
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
    
    private func getActiveGoalsLength()->Int{
        let activeGoalList = fetchActiveGoals() ?? []
        return activeGoalList.count
    }
    
    private func reindex(){
        let activeGoals = fetchActiveGoals()
        if var unwrapped = activeGoals{
            guard unwrapped.count > 0 else{return}
            
            unwrapped.sort{$0.activeListPosition < $1.activeListPosition}
            for i in 0 ... (unwrapped.count - 1){
                unwrapped[i].activeListPosition = Int16(i)
            }
        }
    }
    
    func transmitUpdatedGoalList(){
        let activeGoals = fetchActiveGoals()
        if var goals = activeGoals{
            goals.sort{$0.activeListPosition < $1.activeListPosition}
            var rawDataList: [GoalRawData] = []
            for goal in goals{
                let rawData = GoalRawData(shortName: goal.shortName ?? "NOSHORTNAME", identifierKey: goal.identifierKey ?? "NOIDKEY", activeListPosition: Int(goal.activeListPosition))
                rawDataList.append(rawData)
            }
            GoalsTransmitter.transmitGoalsList(goalsList: rawDataList)
        }
    }
}

extension GoalCDInterface{
    /**
            Only call on first run
     */
    static func populateOnFirstRun(){
        let junkFood = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        junkFood.shortName = "Junk Food"
        junkFood.identifierKey = "Junk Food"
        junkFood.isActive = true
        junkFood.activeListPosition = 0
        junkFood.longDescription = "Log anytime you have an urge to eat or go get junk food. Depending on your goals, it may make sense to split this into Processed Sugars and other types of junk food. Urge = desire, lapse = consuming."
        
        let browse = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        browse.shortName = "Browse"
        browse.identifierKey = "Browse"
        browse.isActive = true
        browse.activeListPosition = 1
        browse.longDescription = "Log anytime you have the urge to aimlessly browse."
        
        let unrelatedWork = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        unrelatedWork.shortName = "Unrelated Work"
        unrelatedWork.identifierKey = "Unrelated Work"
        unrelatedWork.isActive = true
        unrelatedWork.activeListPosition = 2
        
        let judgment = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        judgment.shortName = "Judgment"
        judgment.identifierKey = "Judgment"
        judgment.isActive = true
        judgment.activeListPosition = 3
        judgment.longDescription = "If you want to work on this goal, log whenever you experience negative, judgmental thoughts about someone else or yourself. Urge = the thought occuring to you but you not pursuing it. Lapse = thinking about it."
        
        let posture = Goal(context: CoreDataStore.shared.persistentContainer.viewContext)
        posture.shortName = "Posture"
        posture.identifierKey = "Posture"
        posture.isActive = true
        posture.activeListPosition = 4
        posture.longDescription = "Lapse = realizing you have bad posture when sitting or standing. Urge = wanting to shift into bad posture but realizing it."
        
        CoreDataStore.shared.saveContext()
    }
}
