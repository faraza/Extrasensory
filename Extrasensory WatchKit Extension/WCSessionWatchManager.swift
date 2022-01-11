//
//  WCSessionWatchManager.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/11/22.
//

import Foundation
import WatchKit
import WatchConnectivity

class WCSessionWatchManager: NSObject, WKExtensionDelegate{
    static var session: WCSession?
    static var delegate: SessionDelegate?
    
    private var activationStateObservation: NSKeyValueObservation?
    private var hasContentPendingObservation: NSKeyValueObservation?
    
    private var wcBackgroundTasks = [WKWatchConnectivityRefreshBackgroundTask]()
    
    init(session: WCSession = .default){
        super.init()
        
        activationStateObservation = WCSession.default.observe(\.activationState) { _, _ in
            DispatchQueue.main.async {
                self.completeBackgroundTasks()
            }
        }
        hasContentPendingObservation = WCSession.default.observe(\.hasContentPending) { _, _ in
            DispatchQueue.main.async {
                self.completeBackgroundTasks()
            }
        }
        
        WCSessionWatchManager.session = session
        WCSessionWatchManager.delegate = SessionDelegate()
        if let unwrapped = WCSessionWatchManager.session{
            unwrapped.delegate = WCSessionWatchManager.delegate
            unwrapped.activate()
        }
        else{
            print("ERROR. WCSessionWatchManager. Session is null")
        }
    }
    
    private func completeBackgroundTasks() {
        guard !wcBackgroundTasks.isEmpty else { return }

        guard WCSession.default.activationState == .activated,
            WCSession.default.hasContentPending == false else { return }
        
        wcBackgroundTasks.forEach { $0.setTaskCompleted() }
        
        let date = Date(timeIntervalSinceNow: 1)
        WKExtension.shared().scheduleSnapshotRefresh(withPreferredDate: date, userInfo: nil) { error in
            
            if let error = error {
                print("scheduleSnapshotRefresh error: \(error)!")
            }
        }
        wcBackgroundTasks.removeAll()
    }
}
