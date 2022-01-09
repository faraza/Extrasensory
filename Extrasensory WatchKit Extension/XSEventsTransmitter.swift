//
//  XSEventsTransmitter.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import Foundation

class XSEventsTransmitter {
    
    
    private static func transmitEvent(event: XSEventRawData){
        let encodedEvent = event.encode()
        guard encodedEvent != nil else{
            print("Failed to encode event.")
            return
        }

        if let unwrapped = WCSessionManager.session{
            unwrapped.sendMessage(["event" : encodedEvent!], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
        else{
            print("XSEventsTransmitter::transmitEvent. Session not initialized")
        }
    }
}

extension XSEventsTransmitter{
    static func eventButtonPressed(currentGoal: String, eventType: XSEventType){
        let event = XSEventRawData(typeOfEvent: eventType, timestamp: Date(), goal: currentGoal) //TODO: Fix
        transmitEvent(event: event)
    }    
}
