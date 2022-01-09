//
//  XSEventLoggerView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct XSEventLoggerView: View {
    @StateObject var goalsModel = GoalsModel()
    @State var isLapseInProgress = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var events: FetchedResults<XSEvent>
        
    @State private var fileManagerLength = 0
    
    func addEvent(eventType: XSEventType){
        let newEventEntity = XSEvent(context: managedObjectContext)
        newEventEntity.eventFamily = XSEventFamily.urgeFamily.rawValue
        newEventEntity.urgeFamilyType = eventType.rawValue
        newEventEntity.timestamp = Date()
        newEventEntity.goalKey = goalsModel.currentGoal
        do {
            try managedObjectContext.save()
            print("XSEventLogger. Saved successfully")
        }
        catch{
            print("ERROR -- XSEventLoggerView. Unable to save")
        }
    }
    
    private func getTotalNumberOfEvents()-> Int{
        return XSEventsStore.events.count
    }
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text("Number of events in file manager: \(fileManagerLength)")
                
                GoalsPicker()
                    .environmentObject(goalsModel)
                                
                
                Button(action: {}){
                    Text(XSEventType.urge.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(XSEventType.urge.textColor)
                .simultaneousGesture(LongPressGesture().onEnded { _ in
                    addEvent(eventType: .dangerZone)
                    let haptics = UINotificationFeedbackGenerator()
                    haptics.notificationOccurred(.success)
                })
                .simultaneousGesture(TapGesture().onEnded {
                    addEvent(eventType: .urge)
                })
                                
                Button(action: {}){
                    if(isLapseInProgress){
                        Text(XSEventType.lapseEnd.rawValue)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(minWidth: 1000)
                    }
                    else{
                        Text(XSEventType.lapseStart.rawValue)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(minWidth: 1000)
                    }
                }
                .background(XSEventType.lapseStart.textColor)
                .simultaneousGesture(LongPressGesture().onEnded { _ in
                    addEvent(eventType: .atomicLapse)
                    let haptics = UINotificationFeedbackGenerator()
                    haptics.notificationOccurred(.success)
                    
                })
                .simultaneousGesture(TapGesture().onEnded {
                    if(isLapseInProgress){
                        addEvent(eventType: .lapseEnd)
                    }
                    else{
                        addEvent(eventType: .lapseStart)
                    }
                    isLapseInProgress = !isLapseInProgress
                })
                
            }.navigationTitle("Add Event")
            .onAppear{
                        fileManagerLength = XSEventsStore.events.count
                }
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {    
    static var previews: some View {
        XSEventLoggerView()
    }
}
