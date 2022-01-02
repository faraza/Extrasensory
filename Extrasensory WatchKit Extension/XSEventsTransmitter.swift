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
            print("Reachable: \(unwrapped.isReachable)")
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
