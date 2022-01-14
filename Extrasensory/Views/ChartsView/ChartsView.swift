//
//  ChartsView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/12/22.
//

import SwiftUI

struct ChartsView: View {
    @State private var selectedItem: BarChartEvent = BarChartEvent(hoursPassedSince8AM: -1, numberOfEvents: 0, urgeFamilyType: .atomicLapse)
    
    var urges = BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .urge)
    var lapses = BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .atomicLapse)

    var body: some View {
        VStack{
            Text("Time of Day Breakdown")
                .font(.title)
            GroupedBarChart(selectedItem: $selectedItem, urges: urges, lapses: lapses)
            Text("Swipe left to see more times.")
        }
        .padding(.bottom)
        .padding(.top)
        .padding(.leading)
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
