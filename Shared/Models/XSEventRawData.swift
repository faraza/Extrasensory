//
//  ESEvent.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import Foundation


struct XSEventRawData: Identifiable, Codable{
    let id: UUID
    var eventFamily: XSEventFamily
    var urgeFamilyType: UrgeFamilyType
    var timestamp: Date
    var goal: String
    /**
            Added by the user after
     */
    var description: String = ""
    
    init(id: UUID = UUID(), urgeFamilyType: UrgeFamilyType, timestamp: Date, goal: String){
        self.id = id
        self.urgeFamilyType = urgeFamilyType
        self.timestamp = timestamp
        self.goal = goal
        self.eventFamily = .urgeFamily
    }
        
}

extension XSEventRawData{
    
    func encode() -> Data?{
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(self)
            return data
        }
        catch{
            return nil
        }
    }
}

extension XSEventRawData{
    static func fromXSEvent(event: XSEvent)->XSEventRawData{
        let rawDataEvent = XSEventRawData(urgeFamilyType: UrgeFamilyType(rawValue: event.urgeFamilyType!)!, timestamp: event.timestamp!, goal: event.goalKey!)
        return rawDataEvent
    }
}
