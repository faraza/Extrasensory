//
//  XSEventLoggerView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct XSEventLoggerView: View {
    @Binding var events: [XSEvent]
    @StateObject var goalsModel = GoalsModel()
    @State var isLapseInProgress = false
    
    func addEvent(eventType: XSEventType){
        let newEvent = XSEvent(typeOfEvent: eventType, timestamp: NSDate().timeIntervalSince1970, goal: goalsModel.currentGoal)
        events.append(newEvent)
        XSEventsStore.save(events: events) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
    }
    
//    var lapseButtonText = isLapseInProgress ? XSEventType.lapseEnd.rawValue : XSEventType.lapseStart.rawValue
 
    
    var body: some View {
        NavigationView{
            VStack{
                
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
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {
    @State static var events = XSEvent.sampleData
    static var previews: some View {
        XSEventLoggerView(events: $events)
    }
}
