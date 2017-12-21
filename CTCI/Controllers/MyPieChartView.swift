import Charts

class MyPieChartView:PieChartView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp(){
        drawEntryLabelsEnabled = false
        usePercentValuesEnabled = false
        drawEntryLabelsEnabled = false
        highlightPerTapEnabled = false
        rotationEnabled = false
        drawHoleEnabled = false
        chartDescription?.text = ""
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        data?.setDrawValues(false)

    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry1)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        self.data = pieChartData
        
        pieChartDataSet.colors = [CTCIPalette.completeColor, CTCIPalette.incompleteColor]
    }
}

