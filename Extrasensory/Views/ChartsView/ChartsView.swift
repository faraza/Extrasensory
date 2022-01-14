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
    
    var body: some View {
        ChartsFetcher(selectedGoalKey: selectedGoalKey)
            .padding(.bottom)
            .padding(.top)
            .padding(.leading)
    }
}

struct ChartsFetcher: View{
    var urgeFetchRequest: FetchRequest<XSEvent>
    var lapseFetchRequest: FetchRequest<XSEvent>
    var selectedGoalKey: String
    
    var body: some View{
        VStack{
        ChartsViewContent(urgeEvents: urgeFetchRequest.wrappedValue, lapseEvents: lapseFetchRequest.wrappedValue, selectedGoalKey: selectedGoalKey)
                
        }
    }
    
    init(selectedGoalKey: String){ //TODO: Also take date range
        let urgeGoalPredicate = NSPredicate(format: "goalKey == %@", selectedGoalKey)
        let urgeTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.urge.rawValue)
        let urgePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [urgeGoalPredicate, urgeTypePredicate])
        urgeFetchRequest = FetchRequest<XSEvent>(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: urgePredicate)
        
        let lapsePredicate = NSPredicate(format: "goalKey == %@", selectedGoalKey) //TODO: Include event type in predicate
        lapseFetchRequest = FetchRequest<XSEvent>(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: lapsePredicate)
        self.selectedGoalKey = selectedGoalKey
    }
    
}

struct ChartsViewContent: View{
    @State private var selectedItem: BarChartEvent = BarChartEvent(hoursPassedSince8AM: -1, numberOfEvents: 0, urgeFamilyType: .atomicLapse)

    var urgeEvents: FetchedResults<XSEvent>
    var lapseEvents: FetchedResults<XSEvent>
    
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
    
    init(urgeEvents: FetchedResults<XSEvent>, lapseEvents: FetchedResults<XSEvent>, selectedGoalKey: String){
        self.urgeEvents = urgeEvents
        self.lapseEvents = lapseEvents
        let urgeAndLapse = ChartDataCreator.getUrgeAndLapseChartData(fetchedUrges: urgeEvents, fetchedLapses: lapseEvents)
        urges = urgeAndLapse.urgeData
        lapses = urgeAndLapse.lapseData
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
