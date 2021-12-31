//
//  ESEvent.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import Foundation


struct ESEvent: Identifiable, Codable{
    let id: UUID
    var typeOfEvent: ESEventType
    var timestamp: TimeInterval
    var goal: String
    
    init(id: UUID = UUID(), typeOfEvent: ESEventType, timestamp: TimeInterval, goal: String){
        self.id = id
        self.typeOfEvent = typeOfEvent
        self.timestamp = timestamp
        self.goal = goal
    }
        
}

extension ESEvent{
    
    func getPrintableDate() ->String{
        let curDate = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: curDate)
    }
    
    func getPrintableTime()-> String{
        let curDate = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: curDate)
    }
}

extension ESEvent{
    
    /**
        Returns a map where key is the date and val is array of events that happened on that date, sorted from newest to oldest date
     */
    static func groupEventsByDate(events: [ESEvent]) ->[[ESEvent]]{
        return [] //TODO
    }
}

extension ESEvent{ //Today's Timestamp: 1640923256. ~100,000 is a day
    static let sampleData: [ESEvent] =
    [
        ESEvent(typeOfEvent: ESEventType.atomicLapse, timestamp: 1640923256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640921256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640913256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640903256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640901256, goal: "Biting nails"),
        //Previous day
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640823256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.atomicLapse, timestamp: 1640822256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640821256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640813256, goal: "Biting nails"),
        ESEvent(typeOfEvent: ESEventType.urge, timestamp: 1640810056, goal: "Biting nails")
    ]
}
