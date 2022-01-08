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
    
    /**
        Returns a map where key is the date and val is array of events that happened on that date, sorted from newest to oldest date
     */
    static func groupEventsByDate(events: FetchedResults<XSEventEntity>) ->[XSEventGroup]{
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
