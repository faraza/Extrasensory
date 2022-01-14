//
//  LineChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {
    // NOTE: No Coordinator or delegate functions in this example
    let lineChart = LineChartView()
    var urges : [ChartDataEntry] // there is no LineChartDataEntry as I would have expected
    var lapses: [ChartDataEntry]
    let inDarkMode: Bool
    let xAxisValues: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ lineChart: LineChartView) {
        let urgeDataSet = LineChartDataSet(entries: urges)
        let lapseDataSet = LineChartDataSet(entries: lapses)
        let dataSets: [LineChartDataSet] = [urgeDataSet, lapseDataSet]
        let lineChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lineChartData
        formatDataSet(dataSet: urgeDataSet, label: "Urges", color: .systemYellow)
        formatDataSet(dataSet: lapseDataSet, label: "Lapses", color: .systemRed)
    }
    
    func formatDataSet(dataSet: LineChartDataSet, label: String, color: UIColor) {
        dataSet.label = label
        dataSet.colors = [color]
        dataSet.valueColors = [color]
        dataSet.circleColors = [color]
        dataSet.circleRadius = 4
        dataSet.circleHoleRadius = 0
        dataSet.mode = .horizontalBezier
        dataSet.lineWidth = 4
        dataSet.lineDashLengths = [4]
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
        dataSet.valueFont = UIFont.systemFont(ofSize: 12)
    }

    func configureChart(_ lineChart: LineChartView) {
        lineChart.noDataText = "No Data"
        lineChart.drawGridBackgroundEnabled = true
        lineChart.gridBackgroundColor = UIColor.tertiarySystemFill
        lineChart.drawBordersEnabled = true
        lineChart.rightAxis.enabled = false
        lineChart.setScaleEnabled(false)
        if lineChart.scaleX == 1.0 {
            lineChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
            lineChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
//        let marker:BalloonMarker = BalloonMarker(color: UIColor.red, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//        marker.minimumSize = CGSize(width: 75, height: 35)
//        lineChart.marker = marker
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:xAxisValues)
        xAxis.labelTextColor =  inDarkMode ? UIColor.white : UIColor.black
        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        // Setting the max and min make sure that the markers are visible at the edges
        xAxis.axisMaximum = 12
        xAxis.axisMinimum = -1
    }
    
    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  inDarkMode ? UIColor.white : UIColor.black
        leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
    }

    func formatLegend(legend: Legend) {
        legend.textColor = inDarkMode ? UIColor.white : UIColor.black
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 20.0
    }
}


struct LineChart_Previews: PreviewProvider {
    @Environment(\.colorScheme) static var colorScheme

    static var previews: some View {
        LineChart(
            urges: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemIn),
            lapses: Transaction.lineChartDataForYear(2019, transactions: Transaction.allTransactions, itemType: .itemOut),
            inDarkMode: colorScheme == .dark,
            xAxisValues: Transaction.monthArray)
            .frame(height: 400)
            .padding(.horizontal)
    }
}
