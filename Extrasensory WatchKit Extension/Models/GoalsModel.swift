//
//  GoalsModel.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import Foundation

class GoalsModel: ObservableObject{
    @Published var currentGoal = ""
    @Published var goalsList: [String] = [""]
    
    init(){
        self.goalsList = GoalsModel.sampleGoalsList
        currentGoal = goalsList[0]
    }
    
    init(goalsList: [String]){
        self.goalsList = goalsList
        guard goalsList.count > 0 else{
            return
        }
                
        currentGoal = goalsList[0]
    }
}

extension GoalsModel{
    static let sampleGoalsList = ["Bite Nails", "Browse", "Browse_g", "Judgment", "Sugar", "Vortex"]
}
