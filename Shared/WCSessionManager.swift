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
        WCSessionManager.session = session
        if let unwrapped = WCSessionManager.session{
            unwrapped.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            //TODO
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
