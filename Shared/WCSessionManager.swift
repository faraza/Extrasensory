//
//  WCSessionManager.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/1/22.
//
import Foundation
import WatchConnectivity

class WCSessionManager: NSObject, WCSessionDelegate {
#if os(iOS)

    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
#endif
    
    var session: WCSession
    
    init(session: WCSession = .default){
            self.session = session
            session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            
    }
        
}
