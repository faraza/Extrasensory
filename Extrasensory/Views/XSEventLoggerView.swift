//
//  XSEventLoggerView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct XSEventLoggerView: View {
    @State var isLapseInProgress = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var events: FetchedResults<XSEvent>
            
    func addEvent(eventType: UrgeFamilyType){
        guard SelectedGoalModel.shared.goal != nil else{
            print("Error adding event from iOS loggerView. No goal currently set")
            return
        }
        let newEventEntity = XSEvent(context: managedObjectContext)
        newEventEntity.eventFamily = XSEventFamily.urgeFamily.rawValue
        newEventEntity.urgeFamilyType = eventType.rawValue
        newEventEntity.timestamp = Date()
        newEventEntity.goalKey = SelectedGoalModel.shared.goal!.identifierKey
        do {
            try managedObjectContext.save()
            print("XSEventLogger. Saved successfully")
        }
        catch{
            print("ERROR -- XSEventLoggerView. Unable to save")
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{                
                
                GoalsPicker()
                
                Button(action: {}){
                    Text(UrgeFamilyType.urge.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(UrgeFamilyType.urge.textColor)
                .simultaneousGesture(LongPressGesture().onEnded { _ in
                    addEvent(eventType: .dangerZone)
                    let haptics = UINotificationFeedbackGenerator()
                    haptics.notificationOccurred(.success)
                })
                .simultaneousGesture(TapGesture().onEnded {
                    addEvent(eventType: .urge)
                })
                                
                Button(action: {}){
                    Text(UrgeFamilyType.atomicLapse.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(UrgeFamilyType.lapseStart.textColor)
                .simultaneousGesture(LongPressGesture().onEnded { _ in
                    if(isLapseInProgress){
                        addEvent(eventType: .lapseEnd)
                    }
                    else{
                        addEvent(eventType: .lapseStart)
                    }
                    isLapseInProgress = !isLapseInProgress
                    let haptics = UINotificationFeedbackGenerator()
                    haptics.notificationOccurred(.success)
                })
                .simultaneousGesture(TapGesture().onEnded { _ in
                    addEvent(eventType: .atomicLapse)
                })
                
                
            }.navigationTitle("Add Event")            
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {    
    static var previews: some View {
        XSEventLoggerView()
    }
}
