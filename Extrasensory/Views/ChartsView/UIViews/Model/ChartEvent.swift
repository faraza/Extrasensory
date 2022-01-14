//
//  ChartEvent.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/13/22.
//

import Foundation
import Charts


struct BarChartEvent{
    var hoursPassedSince8AM: Int
    var numberOfEvents: Int
    var urgeFamilyType: UrgeFamilyType

    //var date //TODO
    
    static var selectedItem = BarChartEvent(hoursPassedSince8AM: -1, numberOfEvents: -1, urgeFamilyType: .urge)
    
    static func getHoursArray()->[String]{
        var hoursArray: [String] = []
        for i in 8...11{
            let hourEntry = String(i) + "AM"
            hoursArray.append(hourEntry)
        }
        hoursArray.append("12PM")
        
        for i in 1...11{
            let hourEntry = String(i) + "PM"
            hoursArray.append(hourEntry)
        }
        hoursArray.append("12AM")
        
        for i in 1...7{
            let hourEntry = String(i) + "AM"
            hoursArray.append(hourEntry)
        }
        return hoursArray
    }
    
    static func convertToChartDataEntry(event: BarChartEvent)->BarChartDataEntry{
        return BarChartDataEntry(x: Double(event.hoursPassedSince8AM), y: Double(event.numberOfEvents))
    }
    
    static var urgeSampleEvents:[BarChartEvent]{
        [
            BarChartEvent(hoursPassedSince8AM: 0, numberOfEvents: 11, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 1, numberOfEvents: 15, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 2, numberOfEvents: 0, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 3, numberOfEvents: 0, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 4, numberOfEvents: 4, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 5, numberOfEvents: 4, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 6, numberOfEvents: 0, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 7, numberOfEvents: 3, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 8, numberOfEvents: 8, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 9, numberOfEvents: 9, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 10, numberOfEvents: 20, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 11, numberOfEvents: 6, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 12, numberOfEvents: 3, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 13, numberOfEvents: 4, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 14, numberOfEvents: 9, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 15, numberOfEvents: 20, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 16, numberOfEvents: 1, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 17, numberOfEvents: 3, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 18, numberOfEvents: 4, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 19, numberOfEvents: 0, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 20, numberOfEvents: 1, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 21, numberOfEvents: 3, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 22, numberOfEvents: 8, urgeFamilyType: .urge),
            BarChartEvent(hoursPassedSince8AM: 23, numberOfEvents: 4, urgeFamilyType: .urge),
        ]
    }
    
    static var lapseSampleEvents:[BarChartEvent]{ //TODO: Lapse or urge
        [
            BarChartEvent(hoursPassedSince8AM: 0, numberOfEvents: 11, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 1, numberOfEvents: 15, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 2, numberOfEvents: 0, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 3, numberOfEvents: 0, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 4, numberOfEvents: 4, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 5, numberOfEvents: 4, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 6, numberOfEvents: 0, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 7, numberOfEvents: 3, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 8, numberOfEvents: 8, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 9, numberOfEvents: 9, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 10, numberOfEvents: 20, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 11, numberOfEvents: 6, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 12, numberOfEvents: 3, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 13, numberOfEvents: 4, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 14, numberOfEvents: 9, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 15, numberOfEvents: 20, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 16, numberOfEvents: 1, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 17, numberOfEvents: 3, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 18, numberOfEvents: 4, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 19, numberOfEvents: 0, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 20, numberOfEvents: 1, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 21, numberOfEvents: 3, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 22, numberOfEvents: 8, urgeFamilyType: .atomicLapse),
            BarChartEvent(hoursPassedSince8AM: 23, numberOfEvents: 4, urgeFamilyType: .atomicLapse),
        ]
    }
    
    static func getSampleEventsAsDataEntry(urgeFamilyType: UrgeFamilyType)->[BarChartDataEntry]{
        if urgeFamilyType == .urge{
            return urgeSampleEvents.map{convertToChartDataEntry(event: $0)}
        }
        else{
            return lapseSampleEvents.map{convertToChartDataEntry(event: $0)}
        }
    }
}

struct LineChartEvent{
    
}
