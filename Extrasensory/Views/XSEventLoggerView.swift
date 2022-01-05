//
//  XSEventLoggerView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct XSEventLoggerView: View {
    @StateObject var goalsModel = GoalsModel()

    var body: some View {
        GoalsPicker()
            .environmentObject(goalsModel)
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {
    static var previews: some View {
        XSEventLoggerView()
    }
}
