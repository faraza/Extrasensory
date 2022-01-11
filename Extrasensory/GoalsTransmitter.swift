//
//  GoalsTransmitter.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/10/22.
//

import Foundation

class GoalsTransmitter{
    private static func transmitGoalList(goalList: [GoalRawData]){
        var appContext: [String: [GoalRawData]] = [:] //TODO: Get this
        appContext["goals"] = goalList
        
        if let session = WCSessionManager.session{
            do{
                try session.updateApplicationContext(appContext)
            }
            catch{
                print("GoalsTransimtter. Unable to update app context")
            }
        }
    }    
}
