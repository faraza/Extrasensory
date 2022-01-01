//
//  GoalsModel.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import Foundation

class GoalsModel: ObservableObject{
    @Published var currentGoal = ""
    
    var crownSetGoalIndex: Double = 0 {
        didSet{
            if(Int(crownSetGoalIndex) != currentGoalIndex){
                currentGoalIndex = Int(crownSetGoalIndex)
                currentGoal = goalsList[Int(currentGoalIndex)]
            }
        }
    }
    
    func getGoalsListCount() ->Int{
        return goalsList.count
    }
    
    private var goalsList: [String]
    private var currentGoalIndex: Int = 0
        
    
    init(){
        self.goalsList = GoalsModel.sampleGoalsList
        currentGoalIndex = 0
        crownSetGoalIndex = 0
        currentGoal = goalsList[Int(currentGoalIndex)]
    }
    
    init(goalsList: [String]){
        self.goalsList = goalsList
        guard goalsList.count > 0 else{
            return
        }
        
        currentGoalIndex = 0
        crownSetGoalIndex = 0
        currentGoal = goalsList[Int(currentGoalIndex)]
    }
}

extension GoalsModel{
    static let sampleGoalsList = ["Bite Nails", "Soda", "Browsing", "Sugary Snack"]
}
