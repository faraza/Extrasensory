//
//  WCSessionManager.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/1/22.
//
import Foundation
import WatchConnectivity

class WCSessionManager: NSObject {
    
    static var session: WCSession?
    static var delegate: SessionDelegate?
    
    init(session: WCSession = .default){
        super.init()
        WCSessionManager.session = session
        WCSessionManager.delegate = SessionDelegate()
        if let unwrapped = WCSessionManager.session{
            unwrapped.delegate = WCSessionManager.delegate
            unwrapped.activate()
        }
    }
}
