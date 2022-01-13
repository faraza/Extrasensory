//
//  WCSessionWatchManager.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/11/22.
//

import Foundation
import WatchKit
import WatchConnectivity

class WCSessionWatchManager: NSObject{
    static var session: WCSession?
    static var delegate: SessionDelegate?
    
    init(session: WCSession = .default){
        super.init()
        WCSessionWatchManager.session = session
        WCSessionWatchManager.delegate = SessionDelegate()
        if let unwrapped = WCSessionWatchManager.session{
            unwrapped.delegate = WCSessionWatchManager.delegate
            unwrapped.activate()
            print("Watch session manager activated successfully")
            unwrapped.sendMessage([SessionDelegate.MessageKeys.requestAppContext.rawValue : true], replyHandler: nil) { (error) in
//                print(error.localizedDescription)
            }
        }
    }
}
