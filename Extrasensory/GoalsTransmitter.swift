//
//  GoalsTransmitter.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/10/22.
//

import Foundation

class GoalsTransmitter{
    private static func transmitGoalsList(){
        let appContext: [String: Int] = [:] //TODO: Get this
        
        if let session = WCSessionManager.session{
            do{
                try session.updateApplicationContext(appContext)
            }
            catch{
                print("GoalsTransimtter. Unable to update app context")
            }
        }
    }
    
}
