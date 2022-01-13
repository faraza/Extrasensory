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
    static var currentUrgeGoal: GoalRawData?
    static var currentLapseGoal: GoalRawData?
    
    func setSelectedGoalFromName(goalName: String, fromUrgeView: Bool){
        for goal in goalsList{
            if(goal.shortName == goalName){
                if(fromUrgeView){
                    GoalsListModel.currentUrgeGoal = goal
                }
                else{
                    GoalsListModel.currentLapseGoal = goal
                }
                return
            }
        }
    }
    
    init(useSampleData: Bool = false){
        GoalsListModel.currentUrgeGoal = nil
        GoalsListModel.currentLapseGoal = nil
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(newGoalsListReceived(notification:)), name: Notification.Name(NotificationTypes.goalsListReceivedFromPhone.rawValue), object: nil)
        if(useSampleData){
            setGoalsList(goalsList: GoalsListModel.sampleGoalsList)
        }
    }
    
    func setGoalsList(goalsList: [GoalRawData]){
        guard self.goalsList != goalsList else{
            print("GoalsListModel received goal List that already exists. Returning")
            return
        }
        
        self.goalsList = goalsList
        if goalsList.count > 0{
            GoalsListModel.currentUrgeGoal = goalsList[0]
            GoalsListModel.currentLapseGoal = goalsList[0]
        }
        else{
            GoalsListModel.currentUrgeGoal = nil
            GoalsListModel.currentLapseGoal = nil
        }
    }
}

extension GoalsListModel{
    static let sampleGoalsList = [
        GoalRawData(shortName: "Swag out", identifierKey: "Swag Out", activeListPosition: 0),
        GoalRawData(shortName: "Get Swole", identifierKey: "Get Swole", activeListPosition: 1),
        GoalRawData(shortName: "Get $", identifierKey: "Get $", activeListPosition: 2)
    ]
}

extension GoalsListModel{
    @objc func newGoalsListReceived(notification: Notification){
        guard let newGoalsList = notification.object as? [GoalRawData]
        else{
            print("No event added from notificationCenter")
            return
        }
        setGoalsList(goalsList: newGoalsList)
    }
}
