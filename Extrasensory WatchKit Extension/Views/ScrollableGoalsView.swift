//
//  ScrollableGoalsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct ScrollableGoalsView: View {
    @EnvironmentObject var goalsModel: GoalsModel
    @State var currentInt = 0
    let ints = [1,2,3,4,5]
    var body: some View {
//        Text("\(goalsModel.currentGoal)")
//            .focusable(true)
        Picker("", selection: $currentInt){
            ForEach(ints, id: \.self){ int in
                Text("\(int)")
            }
        }
//            .digitalCrownRotation($goalsModel.crownSetGoalIndex, from: 0, through: Double(goalsModel.getGoalsListCount() - 1), by: 1, sensitivity: .low, isContinuous: true) //TODO: Use WKInterfacePicker later
    }
}

struct ScrollableGoalsView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()
    static var previews: some View {
            ScrollableGoalsView()
                .environmentObject(goalsModel)
    }
}
