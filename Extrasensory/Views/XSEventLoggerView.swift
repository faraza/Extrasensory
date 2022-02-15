//
//  XSEventLoggerView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct XSEventLoggerView: View {
    @State var isLapseInProgress = false
    @State private var selectedGoal: Goal? = nil
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: false)],
                  predicate: NSPredicate(format: "isActive == true"))
    private var activeGoals: FetchedResults<Goal>
            
    func addEvent(eventType: UrgeFamilyType){
        guard selectedGoal != nil else{
            print("ERROR - XSEventLoggerView. Selected goal is nil. Not adding event")
            return
        }
        let newEventEntity = XSEvent(context: managedObjectContext)
        newEventEntity.eventFamily = XSEventFamily.urgeFamily.rawValue
        newEventEntity.urgeFamilyType = eventType.rawValue
        newEventEntity.timestamp = Date()
        newEventEntity.goalKey = selectedGoal!.identifierKey
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
                
                GoalPicker(selectedGoal: $selectedGoal)
                    .onAppear{
                        if(activeGoals.count > 0){
                            if(selectedGoal == nil){
                                selectedGoal = activeGoals[0]
                            }
                        }
                        else{
                            selectedGoal = nil
                        }
                    }
                
                Button(action: {
                    addEvent(eventType: .urge)
                    let haptics = UINotificationFeedbackGenerator()
                    haptics.notificationOccurred(.success)
                }){
                    Text(UrgeFamilyType.urge.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(UrgeFamilyType.urge.textColor)
                                
                Button(action: {
                    addEvent(eventType: .atomicLapse)
                    let haptics = UINotificationFeedbackGenerator()
                    haptics.notificationOccurred(.success)
                }){
                    Text(UrgeFamilyType.atomicLapse.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(UrgeFamilyType.lapseStart.textColor)                
                
            }.navigationTitle("Add Event")            
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {    
    static var previews: some View {
        XSEventLoggerView()
    }
}
