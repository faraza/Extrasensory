//
//  ESEvent.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import Foundation


struct XSEventRawData: Identifiable, Codable{
    let id: UUID
    var typeOfEvent: XSEventType
    var timestamp: TimeInterval
    var goal: String
    /**
            Added by the user after
     */
    var description: String = ""
    
    init(id: UUID = UUID(), typeOfEvent: XSEventType, timestamp: TimeInterval, goal: String){
        self.id = id
        self.typeOfEvent = typeOfEvent
        self.timestamp = timestamp
        self.goal = goal
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

extension XSEventRawData{ //Today's Timestamp: 1640923256. ~100,000 is a day
    static let sampleData: [XSEventRawData] =
    [
//        XSEventRawData(typeOfEvent: XSEventType.atomicLapse, timestamp: Date(timeIntervalSince1970: 1640923256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640921256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640913256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640903256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640901256), goal: "Biting nails"),
//        //Previous day
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640823256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.atomicLapse, timestamp: Date(timeIntervalSince1970: 1640822256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640821256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640813256), goal: "Biting nails"),
//        XSEventRawData(typeOfEvent: XSEventType.urge, timestamp: Date(timeIntervalSince1970: 1640810056), goal: "Biting nails")
    ]
}
