//
//  EventsOverTimeLineChartView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/14/22.
//

import SwiftUI

struct EventsOverTimeLineChartView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack{
            Text("Over Time Breakdown")
            .font(.title)
            LineChart(
            urges: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemIn),
            lapses: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemOut),
            inDarkMode: colorScheme == .dark)
            .frame(height: 400)
            .padding(.horizontal)
            Text("Swipe left for more data")
        }
    }
}

struct EventsOverTimeLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        EventsOverTimeLineChartView()
    }
}
