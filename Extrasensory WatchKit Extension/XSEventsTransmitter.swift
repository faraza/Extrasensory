//
//  XSEventsTransmitter.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import Foundation

class XSEventsTransmitter {
    
    static func urgePressed(currentGoal: String){
        let event = XSEvent(typeOfEvent: .urge, timestamp: NSDate().timeIntervalSince1970, goal: currentGoal)
        let encodedEvent = event.encode()
        guard encodedEvent != nil else{
            print("Failed to encode event.")
            return
        }

        if let unwrapped = WCSessionManager.session{
            unwrapped.sendMessage(["event" : encodedEvent], replyHandler: nil) { (error) in
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
