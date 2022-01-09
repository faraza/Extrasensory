//
//  XSEventEntity.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/7/22.
//

import Foundation
import CoreData
import SwiftUI

extension XSEventEntity{
    static func getAllEvents() -> NSFetchRequest<XSEventEntity>{
        return XSEventEntity.fetchRequest()        
    }
}

extension XSEventEntity{
    
    static func groupEventsByDate(events: FetchedResults<XSEventEntity>) ->[XSEventGroup]{
        var eventsArray: [XSEventEntity] = []
        for event in events{
            eventsArray.append(event)
        }
        return groupEventsByDate(events: eventsArray)
    }
    
    /**
        Returns a map where key is the date and val is array of events that happened on that date, sorted from newest to oldest date
     */
    static func groupEventsByDate(events: [XSEventEntity]) ->[XSEventGroup]{
        var eventsDict: [String: [XSEventEntity]] = [:]
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
                guard $0.timestamp != nil else{return true}
                guard $1.timestamp != nil else{return false}
                return ($0.timestamp! > $1.timestamp!)
            }
            let group = XSEventGroup(events: sorted)
            groupedEvents.append(group)
        }
        
        groupedEvents.sort {
            guard $0.events[0].timestamp != nil else{return true}
            guard $1.events[0].timestamp != nil else{return false}
            return $0.events[0].timestamp! > $1.events[0].timestamp!
        }
        
        return groupedEvents
    }
}

extension XSEventEntity{
    
    func getPrintableDate() ->String{
        if let unwrapped = timestamp{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: unwrapped)
        }
        return "Missing timestamp"
    }
    
    func getPrintableTime()-> String{
        if let unwrapped = timestamp{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: unwrapped)
        }
        return "Missing timestamp"
    }        
}

extension XSEventEntity{
    static func fromData(typeOfEvent: XSEventType, intervalTimeStamp: TimeInterval, goal: String) -> XSEventEntity{
        let event = XSEventEntity(context: CoreDataStore.shared.persistentContainer.viewContext)
        event.typeOfEvent = typeOfEvent.rawValue
        event.timestamp = Date(timeIntervalSince1970: intervalTimeStamp)
        event.goal = goal
        return event
    }
}

extension XSEventEntity{ //Today's Timestamp: 1640923256. ~100,000 is a day
    static let sampleData: [XSEventEntity] =
    [
        XSEventEntity.fromData(typeOfEvent: XSEventType.atomicLapse, intervalTimeStamp: 1640923256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640921256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640913256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640903256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640901256, goal: "Biting nails"),
        //Previous day
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640823256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.atomicLapse, intervalTimeStamp: 1640822256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640821256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640813256, goal: "Biting nails"),
        XSEventEntity.fromData(typeOfEvent: XSEventType.urge, intervalTimeStamp: 1640810056, goal: "Biting nails")
    ]
}

struct XSEventGroup: Identifiable{
    let id: UUID
    var events: [XSEventEntity]
    var groupDate: String = ""
    
    init(id: UUID = UUID(), events: [XSEventEntity]){
        self.id = id
        self.events = events
        if(events.count > 0){
            self.groupDate = events[0].getPrintableDate()
        }
    }
}
