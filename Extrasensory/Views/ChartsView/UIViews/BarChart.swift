//
//  BarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import Charts
import SwiftUI

struct BarChart : UIViewRepresentable {
    @Binding var selectedItem: BarChartEvent
    var entries : [BarChartDataEntry]
    let barChart = BarChartView()
    func makeUIView(context: Context) -> BarChartView {
        barChart.delegate = context.coordinator
        return barChart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }

    func setChartData(_ barChart: BarChartView) {
        let dataSet = BarChartDataSet(entries: entries)
        let barChartData = BarChartData(dataSet: dataSet)
        barChart.data = barChartData
        formatDataSet(dataSet: dataSet)
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.label = "Urges"
        dataSet.highlightAlpha = 0.2
        dataSet.colors = [.systemYellow]
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
    }
    
    func configureChart(_ barChart: BarChartView) {
        barChart.noDataText = "No Data"
        barChart.rightAxis.enabled = false
        barChart.setScaleEnabled(false)
        if barChart.scaleX == 1.0 {
            barChart.zoom(scaleX: 0.5, scaleY: 1, x: 0, y: 0)
        }
        if selectedItem.hoursPassedSince8AM == -1 {
            barChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
            barChart.highlightValue(nil, callDelegate: false)
        }
        barChart.fitBars = true
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:BarChartEvent.getHoursArray())
        xAxis.labelTextColor =  .black
    }

    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.labelTextColor =  .black
    }

    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.black
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        //        legend.yOffset = 30.0
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: BarChart
        init(parent: BarChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            parent.selectedItem.hoursPassedSince8AM = Int(entry.x)
            parent.selectedItem.numberOfEvents = Int(entry.y)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(selectedItem: .constant(BarChartEvent.selectedItem),
                 entries: BarChartEvent.getSampleEventsAsDataEntry(urgeFamilyType: .urge))
    }
}
