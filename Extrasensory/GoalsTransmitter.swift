//
//  GoalsTransmitter.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/10/22.
//

import Foundation

class GoalsTransmitter{
    static func transmitGoalsList(goalsList: [GoalRawData]){
        var appContext: [String: Data?] = [:]
        appContext[GoalRawData.DictionaryKeys.numberOfGoals.rawValue] = String(goalsList.count).data(using: .utf8)
        for goal in goalsList{
            appContext[String(goal.activeListPosition)] = goal.encode()
        }
        
        if let session = WCSessionManager.session{
            do{
                print("GoalsTransmitter::sent App context")
                try session.updateApplicationContext(appContext)
            }
            catch{
                print("GoalsTransmitter. Unable to update app context")
            }
        }
    }    
}
