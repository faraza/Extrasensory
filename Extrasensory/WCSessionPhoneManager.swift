//
//  WCSessionManager.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/1/22.
//
import Foundation
import WatchConnectivity

class WCSessionPhoneManager: NSObject {
    
    static var session: WCSession?
    static var delegate: SessionDelegate?
    
    init(session: WCSession = .default){
        super.init()
        WCSessionPhoneManager.session = session
        WCSessionPhoneManager.delegate = SessionDelegate()
        if let unwrapped = WCSessionPhoneManager.session{
            unwrapped.delegate = WCSessionPhoneManager.delegate
            unwrapped.activate()
        }
    }
}
