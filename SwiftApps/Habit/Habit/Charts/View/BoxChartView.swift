//
//  BoxChartView.swift
//  Habit
//
//  Created by Mateus Lopes on 09/07/25.
//
import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.data = addData()
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.leftAxis.axisLineColor = .orange
        uiView.animate(xAxisDuration: 1.0)
        
        return uiView
    }
    
    private func addData() -> LineChartData? {
        guard !entries.isEmpty else { return nil }
        
        let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let colorsSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 0.1]
        
        guard let gradient = CGGradient(colorsSpace: colorsSpace, colors: colors as CFArray, locations: colorLocations)
        else { return nil }
        
        let set = LineChartDataSet(entries: entries, label: "")
        
        set.mode = .cubicBezier
        set.lineWidth = 2
        set.circleRadius = 4
        set.setColor(.orange)
        set.drawFilledEnabled = true
        set.circleColors = [.red]
        set.valueColors = [.red]
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.fill = LinearGradientFill(gradient: gradient, angle: 90.0)

        
        return LineChartData(dataSet: set)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
}


struct BoxChartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            BoxChartView(entries: .constant([
                ChartDataEntry(x: 1, y: 1),
                ChartDataEntry(x: 2, y: 4),
                ChartDataEntry(x: 3, y: 3),
            ]), dates: .constant([
                "01/01/2025",
                "02/01/2025",
                "03/01/2025",
            ]))
                .frame(maxWidth: .infinity, maxHeight: 350)
                .preferredColorScheme($0)
        }
    }
}
