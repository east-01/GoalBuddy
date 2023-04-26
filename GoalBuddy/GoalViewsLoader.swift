//
//  GoalViewsLoader.swift
//  GoalBuddy
//
//  Created by Ethan Mullen on 4/23/23.
//

import Foundation
import UIKit
import Charts

extension MainViewController : ChartViewDelegate {
    
    /**
        Load all goal views into the bottom UIView
     */
    func loadGoalViews() {
        
        // Clear old views in case they're still there.
        for goalView in goalViews {
            goalView.removeFromSuperview()
        }
        
        // TODO: Temp goal generation, goals will be populated from user profile later.
        let currentDate = Date()
        var goals: [Goal] = []
        for i in 0...10 {
            var reports: [DataReport<Float>] = []
            for j in 0...Int.random(in: 4...10) {
                let newDate = Calendar.current.date(byAdding: .day, value: -j, to: currentDate)
                reports.append(DataReport<Float>(date: newDate!, data: Float.random(in: 5...15)))
            }
            goals.append(NumericGoal(name: "Goal #\(i)", weight: 1.0, targetNumber: 10, reports: reports))
        }

        let goalStackViewSpacing: CGFloat = goalStackView.spacing
        goalStackViewHeight.constant = CGFloat(GoalView.GOALVIEW_HEIGHT * goals.count) + goalStackViewSpacing * CGFloat(goals.count - 1)
        
        // TODO: Test code remove
        // Create chart
        let lineChart = LineChartView()
        lineChart.delegate = self
        lineChart.rightAxis.enabled = false
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineChart)
        NSLayoutConstraint.activate([
            lineChart.widthAnchor.constraint(equalToConstant: 400),
            lineChart.heightAnchor.constraint(equalToConstant: 400),
            lineChart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineChart.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        // Populate entries
        var entries = [ChartDataEntry]()
        var ctr: Int = 0
        for report in (goals[0] as! NumericGoal).getReports() {
            entries.append(ChartDataEntry(x: Double(ctr), y: Double(report.data)))
            ctr+=1
        }
        print(entries.count)
        // Create and populate data
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        lineChart.data = LineChartData(dataSet: set)
        // TODO: End of test code

        // Go through the goals and add them to the stack view
        for goal in goals {
            let goalView = GoalView(goal: goal)
            NSLayoutConstraint.activate([
                goalView.heightAnchor.constraint(equalToConstant: CGFloat(GoalView.GOALVIEW_HEIGHT))
            ])
            goalStackView.addArrangedSubview(goalView)
        }
                
    }
    
}
