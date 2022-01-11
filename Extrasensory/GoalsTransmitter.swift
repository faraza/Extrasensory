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
        
        if let session = WCSessionPhoneManager.session{
            do{
                print("GoalsTransmitter::sent App context")
                try session.updateApplicationContext(appContext)
            }
            catch{
                print("GoalsTransmitter. Unable to update app context")
            }
        }
        _testTransmitMessage()
    }
    
    static func _testTransmitMessage(){
        if let unwrapped = WCSessionPhoneManager.session{
            unwrapped.sendMessage(["testMessage" : "Test message from phone to watch"], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}
