//
//  ScrollableGoalsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct ScrollableGoalsView: View {
    @State var goalIndex: Double = 0

    var body: some View {
        Text("Scroll: \(goalIndex)")
            .focusable(true)
            .digitalCrownRotation($goalIndex, from: 0, through: 5, by: 1, sensitivity: .low, isContinuous: true) //TODO: Use WKInterfacePicker later
    }
}

struct ScrollableGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableGoalsView()
    }
}
