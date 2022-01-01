//
//  ScrollableGoalsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct ScrollableGoalsView: View {
    @EnvironmentObject var goalsModel: GoalsModel

    var body: some View {
        Text("\(goalsModel.currentGoal)")
            .focusable(true)
            .digitalCrownRotation($goalsModel.crownSetGoalIndex, from: 0, through: Double(goalsModel.getGoalsListCount() - 1), by: 1, sensitivity: .low, isContinuous: true) //TODO: Use WKInterfacePicker later
    }
}

struct ScrollableGoalsView_Previews: PreviewProvider {
    @StateObject static var goalsModel = GoalsModel()
    static var previews: some View {
            ScrollableGoalsView()
                .environmentObject(goalsModel)
    }
}
