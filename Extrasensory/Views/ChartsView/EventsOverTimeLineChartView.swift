//
//  EventsOverTimeLineChartView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/14/22.
//

import SwiftUI
import Charts

struct EventsOverTimeChartFetcher: View{
    var urgeFetchRequest: FetchRequest<XSEvent>
    var lapseFetchRequest: FetchRequest<XSEvent>
    
    var body: some View{
        VStack{
            if(urgeFetchRequest.wrappedValue.count > 0 || lapseFetchRequest.wrappedValue.count > 0 ){
                EventsOverTimeViewContent(urgeEvents: urgeFetchRequest.wrappedValue, lapseEvents: lapseFetchRequest.wrappedValue)
            }
            else{
                Text("No data entered for this goal yet")
            }
        }
    }
    
    init(selectedGoalKey: String, startDate: Date, endDate: Date){
        urgeFetchRequest = ChartsView.getUrgeFetchRequest(goalKey: selectedGoalKey, startDate: startDate, endDate: endDate)
        lapseFetchRequest = ChartsView.getLapseFetchRequest(goalKey: selectedGoalKey, startDate: startDate, endDate: endDate)
    }
}

struct EventsOverTimeViewContent: View{
    @Environment(\.colorScheme) var colorScheme
    
    var urgeEvents: FetchedResults<XSEvent>
    var lapseEvents: FetchedResults<XSEvent>
    
    private var urges: [ChartDataEntry]
    private var lapses: [ChartDataEntry]
    private var xAxisValues: [String]

    var body: some View{
        VStack{
            Text("Over Time Breakdown")
                .font(.title)
            LineChart(
                urges: urges,
                lapses: lapses,
                inDarkMode: colorScheme == .dark,
                xAxisValues: xAxisValues)
                .frame(height: 400)
                .padding(.horizontal)
            Text("Swipe left for more data")
        }
    }
    
    init(urgeEvents: FetchedResults<XSEvent>, lapseEvents: FetchedResults<XSEvent>){
        self.urgeEvents = urgeEvents
        self.lapseEvents = lapseEvents
        let urgeAndLapse = ChartDataCreator.getLineChartData(fetchedUrges: urgeEvents, fetchedLapses: lapseEvents)
        urges = urgeAndLapse.urgeData
        lapses = urgeAndLapse.lapseData
        xAxisValues = urgeAndLapse.xAxisLabels
    }
}

/*
struct EventsOverTimeLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        EventsOverTimeLineChartView()
    }
}
*/
