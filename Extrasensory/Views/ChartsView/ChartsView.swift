//
//  ChartsView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/12/22.
//

import SwiftUI
import Charts

struct ChartsView: View {
//    @State var selectedGoalKey = ""
    @State var selectedGoalKey = "Bite Nails" //TODO
    
    var urges = BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .urge)
    var lapses = BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .atomicLapse)
    
    var body: some View {
        ChartsViewContent(selectedGoalKey: selectedGoalKey)
            .padding(.bottom)
            .padding(.top)
            .padding(.leading)
    }
}

extension ChartsView{
    
}

struct ChartsViewContent: View{
    @State private var selectedItem: BarChartEvent = BarChartEvent(hoursPassedSince8AM: -1, numberOfEvents: 0, urgeFamilyType: .atomicLapse)
    
    private var urges: [BarChartDataEntry]
    private var lapses: [BarChartDataEntry]
    var body: some View{
        VStack{
            Text("Time of Day Breakdown")
                .font(.title)
            GroupedBarChart(selectedItem: $selectedItem, urges: urges, lapses: lapses)
            Text("Swipe left to see more times.")
        }
    }
    
    init(selectedGoalKey: String){ //TODO: Also take date range    
        let urgeAndLapse = ChartDataCreator.getUrgeAndLapseFromKey(goalKey: selectedGoalKey)
        urges = urgeAndLapse.urgeData
        lapses = urgeAndLapse.lapseData
    }
    
//    func convertEventListIntoBarChartEntry(eventList: [XSEvent])->[BarChartDataEntry]{
        //TODO
//    }
    
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
