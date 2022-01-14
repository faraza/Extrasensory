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
    
    static func getUrgeAndLapseChartData(fetchedUrges: FetchedResults<XSEvent>, fetchedLapses: FetchedResults<XSEvent>) -> (urgeData: [BarChartDataEntry], lapseData: [BarChartDataEntry]){
        let urgeEvents: [XSEvent] = fetchedUrges.map{$0 as XSEvent}
        let urgeTiming = getTimeOfDayDictionary(events: urgeEvents)
        let urgeData = convertTimeOfDayDictionaryToDataEntries(timingDictionary: urgeTiming)
                
        let lapseEvents: [XSEvent] = fetchedLapses.map{$0 as XSEvent}
        let lapseTiming = getTimeOfDayDictionary(events: lapseEvents)
        let lapseData = convertTimeOfDayDictionaryToDataEntries(timingDictionary: lapseTiming)
        
        return (urgeData, lapseData)
    }
    
    static func getTimeOfDayDictionary(events: [XSEvent])->[Int: Int]{
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
    
    static func convertTimeOfDayDictionaryToDataEntries(timingDictionary: [Int: Int])->[BarChartDataEntry]{
        var dataEntries: [BarChartDataEntry] = []
        for hour in 8...31{ //Starts at 8AM and shifts the dictionary because that's how we display the chart
            let entry = BarChartDataEntry(x: Double(hour-8), y: Double(timingDictionary[hour%24] ?? 0))
            dataEntries.append(entry)
        }
        return dataEntries
    }
}
