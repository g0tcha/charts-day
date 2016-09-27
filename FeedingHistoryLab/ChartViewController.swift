//
//  ChartViewController.swift
//  FeedingHistoryLab
//
//  Created by vincent on 19/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var chartView: CombinedChartView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var valueIndicator: UIView!
    
    // MARK: - Properties
    var times = [TimeInterval]()
    var grams = [Double]()
    
    var currentIndex: Int = 0
    var currentMax: Int = 0
    var currentMin: Int = 0
    var initialIndex = 0
    
    let maxVisibleX = 72.0
    
    var today: String!
    var data: CombinedChartData!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        
        // Initialize todayLabel
        setToday(date: Date().getToday())
        
        valueLabel.layer.borderColor = UIColor.white.cgColor
        valueLabel.layer.borderWidth = 3.0
        valueLabel.layer.cornerRadius = 10
        
        // Customize value indicator
        customizeValueIndicator()
        
        // Prepare grams data chart
        populateChart()
        
        setInitialChartValues()
        
        data = CombinedChartData()
        data.barData = barChartData(values: grams)
        
        chartView.data = data
        
        // Chart style
        setChartStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Helpers methods
    private func setToday(date: String) {
        today = date
        
        UIView.animate(withDuration: 0.4, animations: {
                self.currentDateLabel.alpha = 0.0
            }) { _ in
                UIView.animate(withDuration: 0.7, animations: {
                    self.currentDateLabel.text = date
                    self.currentDateLabel.alpha = 1.0
                })

        }
    }
    
    func checkCurrentChartDate(timestamp: TimeInterval) {
        let date = timestamp.getDayString()
        
        if date != today {
            setToday(date: date)
        }
    }
    
    private func customizeValueIndicator() {
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor.clear.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 128)
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.9]
        
        valueIndicator.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func barChartData(values: [Double]) -> BarChartData {
        var dataEntries: [BarChartDataEntry] = []
        
        let now:TimeInterval = Date().timeIntervalSince1970
        let secondInterval: TimeInterval = 20.0 * 60.0
        let from:TimeInterval = now - Double(values.count) * secondInterval
        
        // Loop through grams values ...
        for i in 0..<values.count {
            let val = values[i] == 0.0 ? 1.0 : values[i]
            let dataEntry = BarChartDataEntry(x: Double(i), y: val)
            
            let timestamp = from + Double(i) * secondInterval
            times.append(timestamp)
            
            // DEBUG
            //print("dataEntry with x = \(i), y = \(val) and timestamp = \(timestamp)")
            
            dataEntries.append(dataEntry)
        }
        
        // Create dataSet
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.axisDependency = .left
        
        // Customize dataSet
        let greenColor = UIColor(red: 87/255, green: 183/255, blue: 20/255, alpha: 1)
        chartDataSet.setColor(NSUIColor(cgColor: greenColor.cgColor))
        chartDataSet.drawValuesEnabled = false
        chartDataSet.highlightEnabled = false
        chartDataSet.barShadowColor = UIColor.clear
        
        // Create chartData
        let chartData = BarChartData(dataSet: chartDataSet)
        
        return chartData
    }
    
    private func setChartStyle() {
        let leftAxis = chartView.leftAxis
        let rightAxis = chartView.rightAxis
        let xAxis = chartView.xAxis
        
        // General
        chartView.backgroundColor = UIColor.clear
        chartView.noDataText = "Sorry. Unable to get data"
        chartView.drawBordersEnabled = false
        chartView.dragEnabled = true
        chartView.borderColor = UIColor.clear
        chartView.borderLineWidth = 0
        chartView.dragDecelerationEnabled = false
        chartView.animate(xAxisDuration: 0.8)
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.borderLineWidth = 0
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        chartView.legend.enabled = false
        chartView.descriptionText = ""
        chartView.drawValueAboveBarEnabled = false
        chartView.setVisibleXRange(minXRange: maxVisibleX, maxXRange: maxVisibleX)
        chartView.centerViewTo(xValue: Double(grams.count - maxVisibleX.toInt() / 2), yValue: grams[grams.count - maxVisibleX.toInt() / 2], axis: YAxis.AxisDependency.left)

        // X Axis
        xAxis.drawLabelsEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = false
        xAxis.drawLimitLinesBehindDataEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = DateValueFormatter(times: times)
        xAxis.labelTextColor = UIColor.white
        xAxis.granularityEnabled = true
        xAxis.granularity = 15

        // Left Axis
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawTopYLabelEntryEnabled = false
        leftAxis.axisMaximum = 40.0
        leftAxis.axisMinimum = 0

        // Right Axis
        rightAxis.enabled = false
    }
    
    func addEnvironmentData() {
        var dataEntries: [ChartDataEntry] = []
        
        let values = generateSampleEnvironmentalData()
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let envDataSet = LineChartDataSet(values: dataEntries, label: "")
        envDataSet.setColor(UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7))
        envDataSet.drawValuesEnabled = false
        envDataSet.highlightEnabled = false
        envDataSet.drawCirclesEnabled = false
        envDataSet.mode = .cubicBezier
        envDataSet.axisDependency = .right
        
        let rightAxis = chartView.rightAxis
        rightAxis.axisMinimum = 0.0
        rightAxis.axisMaximum = 40.0
        
        let chartData = LineChartData(dataSet: envDataSet)
        data.lineData = chartData
        
        chartView.data = data
        chartView.notifyDataSetChanged()
    }
    
}

extension ChartViewController: ChartViewDelegate {
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        // Modify the current read value
        chartValueDidChange()
    }
}

// MARK: - Chart values read / write
private extension ChartViewController {
    func populateChart() {
        var cpt = 1
        let quantity = 10.0
        
        for i in 1...144 {
            if i > 108 {
                grams.append(1.0)
            } else if i % 10 == 0 || i % 11 == 0 || i % 12 == 0 {
                grams.append(quantity * Double(cpt))
                cpt += 1
            } else if i == 36 {
                grams.append(25.0)
            }
            else {
                grams.append(1.0)
            }
            
            if cpt == 3 { cpt = 1 }
        }
    }
    
    func generateSampleEnvironmentalData() -> [Double] {
        var values = [Double]()
        
        for _ in 1...maxVisibleX.toInt() * 2 - 36 {
            values.append(Double(arc4random_uniform(UInt32(20.0))))
        }
        
        return values
    }
    
    func setInitialChartValues() {
        currentIndex = grams.count - maxVisibleX.toInt() / 2 - 1
        
        initialIndex = currentIndex
        
        let midValue = grams[currentIndex]
        
        // DEBUG
        //print("--> INIT - currentIndex = \(currentIndex) currentMin = \(currentMin) currentMax = \(currentMax)")
        //print("--> INIT - midValue = \(midValue)")
        
        self.valueLabel.text = "\(midValue) g"
    }
    
    func chartValueDidChange() {
        let xMin = Int(round(chartView.lowestVisibleX))
        let xMax = Int(round(chartView.highestVisibleX))
        
        if xMin == 0 {
            chartView.setDragOffsetX((self.view.frame.size.width / 2) - 10)
        } else if xMin > 0 {
            chartView.setDragOffsetX(0.0)
        }
        
        let timestamp = times[currentIndex]
        checkCurrentChartDate(timestamp: timestamp)
        
        currentIndex = initialIndex - (grams.count - xMax) + 1
        
        valueLabel.text = "\(self.grams[self.currentIndex]) g"

    }
    
}
