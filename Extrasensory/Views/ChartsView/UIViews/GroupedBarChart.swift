//
//  GroupedBarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import Charts
import SwiftUI

struct GroupedBarChart: UIViewRepresentable {
    @Binding var selectedItem: BarChartEvent
    var urges: [BarChartDataEntry]
    var lapses: [BarChartDataEntry]
    let groupedBarChart = BarChartView()
    let barWidth = 0.35
    let barSpace = 0.05
    let groupSpace = 0.2
    let startX:Double = 0
    func makeUIView(context: Context) -> BarChartView {
        groupedBarChart.delegate = context.coordinator
        return groupedBarChart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        setChartDataAndXaxis(uiView)
        configureChart(uiView)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    func setChartDataAndXaxis(_ barChart: BarChartView) {
        barChart.noDataText = "No Data"
        let dataSetIn = BarChartDataSet(entries: urges)
        let dataSetOut = BarChartDataSet(entries: lapses)
        let dataSets:[BarChartDataSet] = [dataSetIn,dataSetOut]
        let chartData = BarChartData(dataSets: dataSets)
        barChart.data = chartData
        formatDataSet(dataSet: dataSetIn, label: "Urges", color: .systemYellow)
        formatDataSet(dataSet: dataSetOut, label: "Lapses", color: .systemRed)
        let gw = formatChartDataReturnGroupWidth(chartData: chartData)
        formatXAxis(xAxis: barChart.xAxis, groupWidth: gw)
    }
    
    func formatDataSet(dataSet: BarChartDataSet, label: String, color: UIColor) {
        dataSet.label = label
        dataSet.highlightAlpha = 0.2
        dataSet.colors = [color]
        let format = NumberFormatter()
        dataSet.valueColors = [.black]
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
    }

    func formatChartDataReturnGroupWidth(chartData: BarChartData) -> Double {
        // (barWidth + barSpace) * 2 + 0.2 = 1.00 -> interval per "group"
        chartData.barWidth = barWidth
        // fromX is your lowest x value
        chartData.groupBars(fromX: startX, groupSpace: groupSpace, barSpace: barSpace)
        // return the groupWidth as it is necessary for the xAxis
        return chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
    }
    func formatXAxis(xAxis: XAxis, groupWidth: Double) {
        xAxis.axisMaximum = startX + groupWidth * Double(urges.count)
        xAxis.axisMinimum = startX
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:BarChartEvent.getHoursArray())
        xAxis.labelTextColor =  .red
        xAxis.centerAxisLabelsEnabled = true
    }
    
    func configureChart(_ barChart: BarChartView) {
        barChart.noDataText = "No Data"
        barChart.rightAxis.enabled = false
        barChart.setScaleEnabled(false)
        if barChart.scaleX == 1.0 {
            barChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        if selectedItem.hoursPassedSince8AM == -1 {
            barChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
            barChart.highlightValue(nil, callDelegate: false)
        }
    }

    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  .red
    }

    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 0.0
    }

    class Coordinator: NSObject, ChartViewDelegate {
        let parent: GroupedBarChart
        init(parent: GroupedBarChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            parent.selectedItem.hoursPassedSince8AM = Int(entry.x)
            parent.selectedItem.numberOfEvents = Int(entry.y)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

struct GroupedBarChart_Previews: PreviewProvider {
    static var previews: some View {
        GroupedBarChart(selectedItem: .constant(BarChartEvent.selectedItem),
                        urges: BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .urge),
                        lapses: BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .atomicLapse))
    }
}
