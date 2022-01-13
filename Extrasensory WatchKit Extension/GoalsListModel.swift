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
    
    init(){
        goalsList = GoalsListModel.sampleGoalsList //TODO
        
        if goalsList.count > 0{
            GoalsListModel.currentUrgeGoal = goalsList[0]
            GoalsListModel.currentLapseGoal = goalsList[0]
        }
        else{
            GoalsListModel.currentUrgeGoal = nil
            GoalsListModel.currentLapseGoal = nil
        }
    }
    
    func setGoalsList(goalsList: [GoalRawData]){
        if(self.goalsList == goalsList){return}
        //TODO
    }
    
}

extension GoalsListModel{
    static let sampleGoalsList = [
        GoalRawData(shortName: "Swag out", identifierKey: "Swag Out", activeListPosition: 0),
        GoalRawData(shortName: "Get Swole", identifierKey: "Get Swole", activeListPosition: 1),
        GoalRawData(shortName: "Get $", identifierKey: "Get $", activeListPosition: 2)
    ]
}
