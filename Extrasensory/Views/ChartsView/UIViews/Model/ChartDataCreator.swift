//
//  ChartDataCreator.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/13/22.
//

import Foundation
import Charts

/**
 Create an instance of this class and pass it the raw events to get it converted back into chart data
 
 */
class ChartDataCreator{
    
    //TODO: Also take day/date ranges
    public func getUrgeAndLapseFromKey(selectedGoalKey: String) -> (urgeData: [BarChartDataEntry], lapseData: [BarChartDataEntry]){
        var urgeData: [BarChartDataEntry] = []
        var lapseData: [BarChartDataEntry] = []
        
//        urgeData = BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .urge) //TODO
//        lapseData = BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .atomicLapse)
                
        return (urgeData, lapseData)
    }    
}
