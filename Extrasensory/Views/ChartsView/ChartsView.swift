//
//  ChartsView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/14/22.
//

import SwiftUI

struct ChartsView: View {
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: true)])
    private var goals: FetchedResults<Goal>
    @FetchRequest(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var events: FetchedResults<XSEvent>
    
    
    @State var selectedGoal: Goal? = nil
    @State var startDate: Date = ChartsView.placeholderStartDate
    @State var endDate: Date = Date()
        
    
    static private let placeholderStartDate = Date(timeIntervalSince1970: 1609569201) //Jan 1 2021
    
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
            
            ScrollView{
                VStack{
                    TimeOfDayChartFetcher(selectedGoalKey: selectedGoal?.identifierKey ?? "", startDate: startDate, endDate: endDate)
                        .padding(.bottom)
                        .padding(.top)
                        .padding(.leading)
                        .onAppear{
                            if(goals.count > 0 && selectedGoal == nil){
                                selectedGoal = goals[0]
                            }
                        }
                        .frame(height: 500)
                    
                    EventsOverTimeChartFetcher(selectedGoalKey: selectedGoal?.identifierKey ?? "", startDate: startDate, endDate: endDate)
                        .padding(.bottom)
                        .padding(.top)
                        .padding(.leading)
                        .onAppear{
                            if(goals.count > 0 && selectedGoal == nil){
                                selectedGoal = goals[0]
                            }
                            if(events.count > 0 && startDate == ChartsView.placeholderStartDate){
                                startDate = events[0].timestamp!
                            }
                        }
                }
            }
        }
    }
}

extension ChartsView{ //TODO: This can probably be refactored to support DRY
    static func getUrgeFetchRequest(goalKey: String, startDate: Date, endDate: Date)->FetchRequest<XSEvent>{
        let roundedStartDate = Calendar.current.startOfDay(for: startDate)
        let dayAfterEndDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)
        if(dayAfterEndDate == nil){
            print("ERROR - ChartsFetcher. dayAfterEndDay is nil! Endday: \(endDate)")
        }
        
        let roundedEndDate = Calendar.current.startOfDay(for: dayAfterEndDate ?? endDate)
        
        let urgeGoalPredicate = NSPredicate(format: "goalKey == %@", goalKey)
        let urgeTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.urge.rawValue)
        let urgeDateRangePredicate = NSPredicate(format: "timestamp >= %@ AND timestamp <= %@", roundedStartDate as NSDate, roundedEndDate as NSDate)
        let urgePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [urgeGoalPredicate, urgeTypePredicate, urgeDateRangePredicate])
        
        return FetchRequest<XSEvent>(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: urgePredicate)
    }
    
    static func getLapseFetchRequest(goalKey: String, startDate: Date, endDate: Date)->FetchRequest<XSEvent>{
        let roundedStartDate = Calendar.current.startOfDay(for: startDate)
        let dayAfterEndDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)
        if(dayAfterEndDate == nil){
            print("ERROR - ChartsFetcher. dayAfterEndDay is nil! Endday: \(endDate)")
        }
        let roundedEndDate = Calendar.current.startOfDay(for: dayAfterEndDate ?? endDate)
        let lapseGoalPredicate = NSPredicate(format: "goalKey == %@", goalKey)
        let lapseAtomicTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.atomicLapse.rawValue)
        let lapseStartTypePredicate = NSPredicate(format: "urgeFamilyType == %@", UrgeFamilyType.lapseStart.rawValue)
        let lapseDateRangePredicate = NSPredicate(format: "timestamp >= %@ AND timestamp <= %@", roundedStartDate as NSDate, roundedEndDate as NSDate)
        let lapsePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [lapseGoalPredicate, lapseDateRangePredicate, NSCompoundPredicate(orPredicateWithSubpredicates: [lapseAtomicTypePredicate, lapseStartTypePredicate])])
        
        return FetchRequest<XSEvent>(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)], predicate: lapsePredicate)
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
