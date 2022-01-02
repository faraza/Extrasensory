//
//  XSEventsTransmitter.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import Foundation

class XSEventsTransmitter {
    
    static func urgePressed(currentGoal: String){
        //TODO
        print("XSEventsTransmitter::urgePressed. Habit: \(currentGoal)")
        if let unwrapped = WCSessionManager.session{
            unwrapped.sendMessage(["message" : "XSMessage test 1"], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
        else{
            print("XSEventsTransmitter::urgePressed. Session not initialized")
        }
    }
    
    static func lapseStartPressed(currentGoal: String){
        //TODO
        print("XSEventsTransmitter::lapseStartPressed. Habit: \(currentGoal)")
    }
    
    static func lapseEndPressed(currentGoal: String){
        //TODO
        print("XSEventsTransmitter::lapseEndPressed. Habit: \(currentGoal)")
    }
    
    static func atomicLapsePressed(currentGoal: String){
        //TODO
        print("XSEventsTransmitter::atomicLapsePressed. Habit: \(currentGoal)")
    }
}
