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
        drawHoleEnabled = false
        usePercentValuesEnabled = true
        chartDescription?.text = ""
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry1)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        self.data = pieChartData
        
        pieChartDataSet.colors = [CTCIPalette.completeColor, CTCIPalette.incompleteColor]
    }
}

