//
//  ChartsView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/12/22.
//

import SwiftUI
import Charts

struct ChartsView: View {
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: true)])
    private var goals: FetchedResults<Goal>

    @State var selectedGoal: Goal? = nil
    @State var startDate: Date = Date(timeIntervalSince1970: 1609569201) //Jan 1 2021
    @State var endDate: Date = Date()
    
    var body: some View {
        VStack{
            HStack{
                Text("Goal:")
                Picker("", selection: $selectedGoal){
                    ForEach(goals, id: \.self){ goal in
                        Text("\(goal.shortName ?? "NOSHORTNAMESET")").tag(goal as Goal?)
                    }
                }
            }
            HStack{
                Text("Start:")
                DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                    .labelsHidden()
                Text("End:")
                DatePicker("End Date", selection: $endDate, in: startDate...Date(), displayedComponents: .date)
                    .labelsHidden()
            }
            HStack{
                
            }
            
            ChartsFetcher(selectedGoalKey: selectedGoal?.identifierKey ?? "", startDate: startDate, endDate: endDate)
                .padding(.bottom)
                .padding(.top)
                .padding(.leading)
                .onAppear{
                    if(goals.count > 0 && selectedGoal == nil){
                        selectedGoal = goals[0]
                    }
                }
        }
    }
}

/*
 We have to use this ridiculous injection construct so the fetch predicate updates and causes a re-render when
 the core data changes.
 */
struct ChartsFetcher: View{
    var urgeFetchRequest: FetchRequest<XSEvent>
    var lapseFetchRequest: FetchRequest<XSEvent>
    
    var body: some View{
        VStack{
            if(urgeFetchRequest.wrappedValue.count > 0 || lapseFetchRequest.wrappedValue.count > 0 ){
                ChartsViewContent(urgeEvents: urgeFetchRequest.wrappedValue, lapseEvents: lapseFetchRequest.wrappedValue)
            }
            else{
                Text("No data entered for this goal yet")
            }
        }
    }
    
    init(selectedGoalKey: String, startDate: Date, endDate: Date){
        let roundedStartDate = Calendar.current.startOfDay(for: startDate)
        let dayAfterEndDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)
        if(dayAfterEndDate == nil){
            print("ERROR - ChartsFetcher. dayAfterEndDay is nil! Endday: \(endDate)")
        }
        let roundedEndDate = Calendar.current.startOfDay(for: dayAfterEndDate ?? endDate)
        
        let urgeGoalPredicate = NSPredicate(format: "goalKey == %@", selectedGoalKey)
        let urgeTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.urge.rawValue)
        let urgeDateRangePredicate = NSPredicate(format: "timestamp >= %@ AND timestamp <= %@", roundedStartDate as NSDate, roundedEndDate as NSDate)
        let urgePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [urgeGoalPredicate, urgeTypePredicate, urgeDateRangePredicate])
        urgeFetchRequest = FetchRequest<XSEvent>(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: urgePredicate)
        
        let lapseGoalPredicate = NSPredicate(format: "goalKey == %@", selectedGoalKey)
        let lapseAtomicTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.atomicLapse.rawValue)
        let lapseStartTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.lapseStart.rawValue)
        let lapseDateRangePredicate = NSPredicate(format: "timestamp >= %@ AND timestamp <= %@", roundedStartDate as NSDate, roundedEndDate as NSDate)
        let lapsePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [lapseGoalPredicate, lapseDateRangePredicate, NSCompoundPredicate(orPredicateWithSubpredicates: [lapseAtomicTypePredicate, lapseStartTypePredicate])])
        lapseFetchRequest = FetchRequest<XSEvent>(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: lapsePredicate)
    }
}

/**
 We have to use this ridiculous injection construct so the chart data updates when core data updates
 */
struct ChartsViewContent: View{
    @Environment(\.colorScheme) var colorScheme

    @State private var selectedItem: BarChartEvent = BarChartEvent(hoursPassedSince8AM: -1, numberOfEvents: 0, urgeFamilyType: .atomicLapse)

    var urgeEvents: FetchedResults<XSEvent>
    var lapseEvents: FetchedResults<XSEvent>
    
    private var urges: [BarChartDataEntry]
    private var lapses: [BarChartDataEntry]
    
    var body: some View{
        VStack{
            Text("Time of Day Breakdown")
                .font(.title)
            GroupedBarChart(selectedItem: $selectedItem, urges: urges, lapses: lapses, inDarkMode: colorScheme == .dark)
            Text("Swipe left to see more times.")
        }
    }
    
    init(urgeEvents: FetchedResults<XSEvent>, lapseEvents: FetchedResults<XSEvent>){
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
