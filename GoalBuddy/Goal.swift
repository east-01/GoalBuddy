//
//  Goal.swift
//  GoalBuddy
//
//  Created by Ethan Mullen on 4/23/23.
//

import Foundation

class Goal {
    private var name: String
    private var weight: Float
    init(name: String, weight: Float) {
        self.weight = weight
        self.name = name
    }
    
    func getName() -> String {
        return self.name
    }
}

/**
 Goal type where the target is a numerical value.
 */
class NumericGoal : Goal {
    private var targetNumber: Float
    private var reports: [DataReport<Float>]
    init(name: String, weight: Float, targetNumber: Float, reports: [DataReport<Float>]) {
        self.targetNumber = targetNumber
        self.reports = reports
        super.init(name: name, weight: weight)
    }
    func getReports() -> [DataReport<Float>] {
        return reports
    }
}

struct DataReport<T> {
    let date: Date
    let data: T
    init(date: Date, data: T) {
        self.date = date
        self.data = data
    }
}
