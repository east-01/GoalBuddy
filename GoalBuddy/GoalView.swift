//
//  GoalView.swift
//  GoalBuddy
//
//  Created by Ethan Mullen on 4/23/23.
//

import UIKit

class GoalView: UIView {

    static var GOALVIEW_HEIGHT = 100
    
    var goal: Goal
    
    var nameLabel: UILabel
    
    init(goal: Goal) {
        self.goal = goal
        self.nameLabel = UILabel()
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        commonInit()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func commonInit() {

        self.backgroundColor = .cyan
        self.layer.cornerRadius = 15
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = goal.getName()
        self.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
    }
    
}
