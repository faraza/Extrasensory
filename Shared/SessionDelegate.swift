//
//  SessionDelegate.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/11/22.
//

import Foundation

import Foundation
import WatchConnectivity

class SessionDelegate: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            print("WCSessionManager. Message received: \(message)")
            if let encodedEvent = message["event"] as? Data{
                do{
                    let decoder = JSONDecoder()
                    let event = try decoder.decode(XSEventRawData.self, from: encodedEvent)
                    let nc = NotificationCenter.default
                    nc.post(name: NSNotification.Name(NotificationTypes.xsEventReceivedFromWatch.rawValue), object: event)
                }
                catch{
                    print("Failed to decode event")
                }
                
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Application Context received. Outer")
        DispatchQueue.main.async() {
            print("Application Context received. Async")
            /*if let goalsList = applicationContext["goal"] as? [GoalRawData]{
                print("Goals list found: \(goalsList)")
                let nc = NotificationCenter.default
                nc.post(name: NSNotification.Name(NotificationTypes.goalsListReceivedFromPhone.rawValue), object: goalsList)
            } */
        }
    }
    
    
#if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
#endif
}
