//
//  ESEvent.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import Foundation


struct XSEvent: Identifiable, Codable{
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

extension XSEvent{
    
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

extension XSEvent{
    
    /**
        Returns a map where key is the date and val is array of events that happened on that date, sorted from newest to oldest date
     */
    static func groupEventsByDate(events: [XSEvent]) ->[XSEventGroup]{
        var eventsDict: [String: [XSEvent]] = [:]
        for event in events {
            if var newVal = eventsDict[event.getPrintableDate()]{
                newVal.append(event)
                eventsDict[event.getPrintableDate()] = newVal
            }
            else{
                eventsDict[event.getPrintableDate()] = [event]
            }
        }
        
        var groupedEvents: [XSEventGroup] = []
        for(_, dictionaryEvents) in eventsDict{
            let sorted = dictionaryEvents.sorted {
                $0.timestamp > $1.timestamp
            }
            let group = XSEventGroup(events: sorted)
            groupedEvents.append(group)
        }
        
        groupedEvents.sort {
            $0.events[0].timestamp > $1.events[0].timestamp
        }
        
        return groupedEvents
    }
}

struct XSEventGroup: Identifiable, Codable{
    let id: UUID
    var events: [XSEvent]
    var groupDate: String = ""
    
    init(id: UUID = UUID(), events: [XSEvent]){
        self.id = id
        self.events = events
        if(events.count > 0){
            self.groupDate = events[0].getPrintableDate()
        }
    }
}

extension XSEvent{ //Today's Timestamp: 1640923256. ~100,000 is a day
    static let sampleData: [XSEvent] =
    [
        XSEvent(typeOfEvent: XSEventType.atomicLapse, timestamp: 1640923256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640921256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640913256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640903256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640901256, goal: "Biting nails"),
        //Previous day
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640823256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.atomicLapse, timestamp: 1640822256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640821256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640813256, goal: "Biting nails"),
        XSEvent(typeOfEvent: XSEventType.urge, timestamp: 1640810056, goal: "Biting nails")
    ]
}
