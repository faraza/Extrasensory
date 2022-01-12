//
//  GoalsListModel.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 1/12/22.
//

import Foundation

/**
 Stores the latest goals list for the watch app.
 Listens for updates from the network and updates the list accordingly
 */
class GoalsListModel: ObservableObject{
    @Published var goalsList: [GoalRawData] = []
    static var currentlySelectedGoal: GoalRawData?
    
    init(){
        goalsList = GoalsListModel.sampleGoalsList //TODO
        guard goalsList.count > 0 else{return}
        
        GoalsListModel.currentlySelectedGoal = goalsList[0]

        //        let nc = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(xsEventAddedFromWatch(notification:)), name: Notification.Name(NotificationTypes.xsEventReceivedFromWatch.rawValue), object: nil)
    }
    
    /*@objc func xsEventAddedFromWatch(notification: Notification){
        guard let newEventRawData = notification.object as? XSEventRawData
        else{
            print("No event added from notificationCenter")
            return
        }
        let event = XSEvent(context: persistentContainer.viewContext)
        event.timestamp = newEventRawData.timestamp
        event.eventFamily = XSEventFamily.urgeFamily.rawValue
        event.urgeFamilyType = newEventRawData.urgeFamilyType.rawValue
        event.goalKey = newEventRawData.goal
        saveContext()
    } */
}

extension GoalsListModel{
    static let sampleGoalsList = [
        GoalRawData(shortName: "Swag out", identifierKey: "Swag Out", activeListPosition: 0),
        GoalRawData(shortName: "Get Swole", identifierKey: "Get Swole", activeListPosition: 1),
        GoalRawData(shortName: "Get $", identifierKey: "Get $", activeListPosition: 2)
    ]
}
