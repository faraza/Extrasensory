//
//  EventsOverTimeLineChartView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/14/22.
//

import SwiftUI

struct EventsOverTimeLineChartView: View {
    var body: some View {
        VStack{
            Text("Over Time Breakdown")
            .font(.title)
            LineChart(
            entriesIn: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemIn),
            entriesOut: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemOut))
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
