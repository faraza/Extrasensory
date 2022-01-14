//
//  ChartDataCreator.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/13/22.
//

import Foundation
import Charts
import SwiftUI

/**
 Create an instance of this class and pass it the raw events to get it converted back into chart data
 
 */
class ChartDataCreator{
    
    //TODO: Also take day/date ranges
    static func getUrgeAndLapseChartData(fetchedUrges: FetchedResults<XSEvent>, fetchedLapses: FetchedResults<XSEvent>) -> (urgeData: [BarChartDataEntry], lapseData: [BarChartDataEntry]){
        print("Chart data creator called")
        
//        let urgeEvents = fetchEventsFromKey(goalKey: goalKey, eventType: UrgeFamilyType.urge.rawValue)
        let urgeEvents: [XSEvent] = fetchedUrges.map{$0 as XSEvent}
        let urgeTiming = getEventTimingDictionary(events: urgeEvents)
        let urgeData = convertTimingDictionaryToChartDataEntries(timingDictionary: urgeTiming)
                
        let lapseData: [BarChartDataEntry] = []
        return (urgeData, lapseData)
    }
    
    static func fetchEventsFromKey(goalKey: String, eventType: String)->[XSEvent]{
        let fetchRequest = XSEvent.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "goalKey == %@", goalKey) //TODO: Include event type in predicate
        do{
            return try CoreDataStore.shared.persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }
    
    static func getEventTimingDictionary(events: [XSEvent])->[Int: Int]{
        var timingDictionary: [Int: Int] = [:]
        for i in 0...23{
            timingDictionary[i] = 0
        }
        
        for event in events{
            guard event.timestamp != nil else{continue}
            
            let eventHour = Calendar.current.component(.hour, from: event.timestamp!)
            timingDictionary[eventHour]! += 1
        }
        return timingDictionary
    }
    
    static func convertTimingDictionaryToChartDataEntries(timingDictionary: [Int: Int])->[BarChartDataEntry]{
        var dataEntries: [BarChartDataEntry] = []
        for hour in 8...31{ //Starts at 8AM and shifts the dictionary because that's how we display the chart
            let entry = BarChartDataEntry(x: Double(hour-8), y: Double(timingDictionary[hour%24] ?? 0))
            dataEntries.append(entry)
        }
        return dataEntries
    }
}
