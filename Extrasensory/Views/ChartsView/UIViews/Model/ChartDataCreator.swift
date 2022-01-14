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
        
    
    static func getBarChartData(fetchedUrges: FetchedResults<XSEvent>, fetchedLapses: FetchedResults<XSEvent>) -> (urgeData: [BarChartDataEntry], lapseData: [BarChartDataEntry]){
        let urgeEvents: [XSEvent] = fetchedUrges.map{$0 as XSEvent}
        let urgeTiming = getTimeOfDayDictionary(events: urgeEvents)
        let urgeData = convertTimeOfDayDictionaryToDataEntries(timingDictionary: urgeTiming)
                
        let lapseEvents: [XSEvent] = fetchedLapses.map{$0 as XSEvent}
        let lapseTiming = getTimeOfDayDictionary(events: lapseEvents)
        let lapseData = convertTimeOfDayDictionaryToDataEntries(timingDictionary: lapseTiming)
        
        return (urgeData, lapseData)
    }
    
    private static func getTimeOfDayDictionary(events: [XSEvent])->[Int: Int]{
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
        
    private static func convertTimeOfDayDictionaryToDataEntries(timingDictionary: [Int: Int])->[BarChartDataEntry]{
        var dataEntries: [BarChartDataEntry] = []
        for hour in 8...31{ //Starts at 8AM and shifts the dictionary because that's how we display the chart
            let entry = BarChartDataEntry(x: Double(hour-8), y: Double(timingDictionary[hour%24] ?? 0))
            dataEntries.append(entry)
        }
        return dataEntries
    }
    
    static func getLineChartData(fetchedUrges: FetchedResults<XSEvent>, fetchedLapses: FetchedResults<XSEvent>) -> (urgeData: [ChartDataEntry], lapseData: [ChartDataEntry], xAxisLabels: [String]){
        let urgeEvents: [XSEvent] = fetchedUrges.map{$0 as XSEvent} //TODO
        let urgeTiming = getEventsPerDayDictionary(events: urgeEvents)
                
        let lapseEvents: [XSEvent] = fetchedLapses.map{$0 as XSEvent}
        let lapseTiming = getEventsPerDayDictionary(events: lapseEvents)
        
        let startDate = min(urgeTiming.startDate, lapseTiming.startDate)
        let endDate = max(urgeTiming.endDate, lapseTiming.endDate)
        
        let urgeData = convertEventsPerDayDictionaryToDataEntries(timingDictionary: urgeTiming.dictionary, startDate: startDate, endDate: endDate)
        let lapseData = convertEventsPerDayDictionaryToDataEntries(timingDictionary: lapseTiming.dictionary, startDate: startDate, endDate: endDate)
        
        var xAxisLabels: [String] = []
        var currentDate = startDate
        while(currentDate <= endDate){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            xAxisLabels.append(dateFormatter.string(from: currentDate))
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return (urgeData, lapseData, xAxisLabels)
    }
    
    
    private static func getEventsPerDayDictionary(events: [XSEvent])->(dictionary: [Date: Int], startDate: Date, endDate: Date){
        var perDayDictionary: [Date: Int] = [:]
        var startDate = Date()
        var endDate = Date()
        
        guard events.count > 0 else{return (dictionary: perDayDictionary, startDate: startDate, endDate: endDate)}
        
        let sortedEvents = events.sorted{
            guard $0.timestamp != nil else{ return true}
            guard $1.timestamp != nil else{return false}
                
            return $0.timestamp! < $1.timestamp!
        }
        startDate = stripTimeFromDate(date: sortedEvents[0].timestamp!)
        endDate = stripTimeFromDate(date: sortedEvents[events.count - 1].timestamp!)
                
        for event in sortedEvents{
            if let rawTimestamp = event.timestamp{
                let timestamp = stripTimeFromDate(date: rawTimestamp)
                perDayDictionary[timestamp] = (perDayDictionary[timestamp] ?? 0) + 1
            }
        }
                
        return (dictionary: perDayDictionary, startDate: startDate, endDate: endDate)
    }
    
    private static func stripTimeFromDate(date: Date)->Date{
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let strippedDate = Calendar.current.date(from: components)
        return strippedDate!
    }
    
    private static func convertEventsPerDayDictionaryToDataEntries(timingDictionary: [Date: Int], startDate: Date, endDate: Date)->[ChartDataEntry]{
        var dataEntries: [ChartDataEntry] = []
        
        var currentDate = startDate
        while(currentDate <= endDate){
            let daysSinceStart = Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day!
            let numberOfEvents = timingDictionary[currentDate] ?? 0
            dataEntries.append(ChartDataEntry(x: Double(daysSinceStart), y: Double(numberOfEvents)))
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dataEntries
    }
}
