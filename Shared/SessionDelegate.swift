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
            if let encodedEvent = message[MessageKeys.event.rawValue] as? Data{
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
            else if let _ = message[MessageKeys.requestAppContext.rawValue] as? Bool{
                print("App context requested")
                #if os(iOS)
                GoalCDInterface.shared.transmitUpdatedGoalList()
                #endif
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async() {
            if let numberOfGoals = applicationContext[GoalRawData.DictionaryKeys.numberOfGoals.rawValue] as? Int{
                var goalsList: [GoalRawData] = []
                for i in 0...numberOfGoals{
                    if let newGoalEncoded = applicationContext[String(i)] as? Data{
                        do{
                            let decoder = JSONDecoder()
                            let newGoal = try decoder.decode(GoalRawData.self, from: newGoalEncoded)
                            goalsList.append(newGoal)
                        }
                        catch{
                            print("SessionDelegate:: Failed to decode goal")
                        }
                    }
                }
                
                let nc = NotificationCenter.default
                nc.post(name: NSNotification.Name(NotificationTypes.goalsListReceivedFromPhone.rawValue), object: goalsList)
            }
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

extension SessionDelegate{
    enum MessageKeys: String{
        case event = "event"
        case requestAppContext = "requestAppContext"
    }
}
