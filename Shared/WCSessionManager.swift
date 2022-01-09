//
//  WCSessionManager.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/1/22.
//
import Foundation
import WatchConnectivity

class WCSessionManager: NSObject, WCSessionDelegate {
    
    static var session: WCSession?
    
    init(session: WCSession = .default){
        super.init()
        WCSessionManager.session = session
        if let unwrapped = WCSessionManager.session{
            unwrapped.delegate = self
            unwrapped.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Message receive start")
        DispatchQueue.main.async {
            
            if let encodedEvent = message["event"] as? Data{
                do{
                    let decoder = JSONDecoder()
                    let event = try decoder.decode(XSEventRawData.self, from: encodedEvent)
                    let nc = NotificationCenter.default
                    nc.post(name: NSNotification.Name(NotificationTypes.xsEventReceived.rawValue), object: event)
                }
                catch{
                    print("Failed to decode event")
                }
                
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
