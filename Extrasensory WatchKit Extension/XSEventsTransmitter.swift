//
//  XSEventsTransmitter.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import Foundation

class XSEventsTransmitter {
    
    
    private static func transmitEvent(event: XSEvent){
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
            print("XSEventsTransmitter::transmitEvent. Session not initialized")
        }
    }
}

extension XSEventsTransmitter{
    static func urgePressed(currentGoal: String){
        let event = XSEvent(typeOfEvent: .urge, timestamp: NSDate().timeIntervalSince1970, goal: currentGoal)
        transmitEvent(event: event)
    }
    
    static func lapseStartPressed(currentGoal: String){
        let event = XSEvent(typeOfEvent: .lapseStart, timestamp: NSDate().timeIntervalSince1970, goal: currentGoal)
        transmitEvent(event: event)
    }
    
    static func lapseEndPressed(currentGoal: String){
        let event = XSEvent(typeOfEvent: .lapseEnd, timestamp: NSDate().timeIntervalSince1970, goal: currentGoal)
        transmitEvent(event: event)
    }
    
    static func atomicLapsePressed(currentGoal: String){
        let event = XSEvent(typeOfEvent: .atomicLapse, timestamp: NSDate().timeIntervalSince1970, goal: currentGoal)
        transmitEvent(event: event)
    }
}
