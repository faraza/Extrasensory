//
//  GoalsTransmitter.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/10/22.
//

import Foundation

class GoalsTransmitter{
    static func transmitGoalsList(goalsList: [GoalRawData]){
        var appContext: [String: Any] = [:]

        appContext[GoalRawData.DictionaryKeys.numberOfGoals.rawValue] = goalsList.count
        for goal in goalsList{
            appContext[String(goal.activeListPosition)] = goal.encode()
        }
        
        if let session = WCSessionPhoneManager.session{
            do{
                print("GoalsTransmitter::sent App context")
                try session.updateApplicationContext(appContext)
//                _testTransmitMessage()
            }
            catch{
                print("GoalsTransmitter. Unable to update app context")
            }
        }
    }
    
    static func _testTransmitMessage(){
        if let unwrapped = WCSessionPhoneManager.session{
            print("GoalsTransmitter::_testTransmitMessage. Session reachable: \(unwrapped.isReachable) Installed: \(unwrapped.isWatchAppInstalled)")
            
            unwrapped.sendMessage(["testMessage" : "Test message from phone to watch"], replyHandler: nil) { (error) in
                print("ERROR - failed to transmit message: \(error.localizedDescription)")
            }
        }
    }
}
