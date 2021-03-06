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

        if let unwrapped = WCSessionWatchManager.session{
            unwrapped.sendMessage([SessionDelegate.MessageKeys.event.rawValue : encodedEvent!], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
        else{
            print("XSEventsTransmitter::transmitEvent. Session not initialized")
        }
    }
}

extension XSEventsTransmitter{
    static func eventButtonPressed(currentGoal: String, eventType: UrgeFamilyType){
        let event = XSEventRawData(urgeFamilyType: eventType, timestamp: Date(), goal: currentGoal)
        transmitEvent(event: event)
    }    
}
