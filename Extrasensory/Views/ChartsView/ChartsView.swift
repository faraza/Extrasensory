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

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
