//
//  ViewController.swift
//  GoalBuddy
//
//  Created by Ethan Mullen on 3/24/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewYLoc: NSLayoutConstraint!
    @IBOutlet weak var bottomViewExpandButton: UIButton!
    let BOTTOM_VIEW_YLOC_DEFAULT: CGFloat = -550
    let BOTTOM_VIEW_YLOC_EXPANDED: CGFloat = 0
    var isBottomViewExpanded: Bool = false
    var startingPanHeight: CGFloat = 0
    
    @IBOutlet weak var goalStackView: UIStackView!
    @IBOutlet weak var goalStackViewHeight: NSLayoutConstraint!
    var goalViews: [GoalView] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.layer.cornerRadius = 15
        titleView.layer.shadowOffset = CGSize(width: -10, height: 10)
        titleView.layer.shadowColor = UIColor.black.cgColor
        titleView.layer.shadowOpacity = 0.25
        
        titleLabel.text = getDateString()
        
        loadProfileImage();
        
        bottomView.layer.cornerRadius = 15
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        panGesture.maximumNumberOfTouches = 1
        panGesture.minimumNumberOfTouches = 1
        bottomView.addGestureRecognizer(panGesture)
                
        loadGoalViews()
        
        let goal: IntegerGoal = IntegerGoal(name: "bruh", weight: 1, value: 0, target: 50);
        goal.printIntegerGoal()
        
    }
    
    func loadProfileImage() {
        
        let resizedImage = resizeImage(image: UIImage(named: "ProfilePic")!, targetSize: CGSize(width: 50, height: 50))
        let croppedImage = cropToBounds(image: resizedImage!, width: 50, height: 50)
        profileButton.setImage(croppedImage, for: .normal)
        profileButton.layer.cornerRadius = 25
        profileButton.clipsToBounds = true
        
    }
    
    @IBAction func expandButtonTapped(_ sender: Any) {
        setBottomViewExpanded(isExpanded: !isBottomViewExpanded)
    }
    
    @objc func panHandler(_ gestureRecognizer : UIPanGestureRecognizer) {
        // Get loc and set the starting height if needed
        let loc = gestureRecognizer.location(in: bottomView.superview!)
        if(gestureRecognizer.state == .began) {
            startingPanHeight = loc.y
        }
        // Calculate swipe offset
        let offset: CGFloat = startingPanHeight - loc.y
        var newYLoc = (isBottomViewExpanded ? BOTTOM_VIEW_YLOC_EXPANDED : BOTTOM_VIEW_YLOC_DEFAULT) + offset
        // Make sure swipe stays in bounds
        if(newYLoc > BOTTOM_VIEW_YLOC_EXPANDED) {
            newYLoc = BOTTOM_VIEW_YLOC_EXPANDED
        } else if(newYLoc < BOTTOM_VIEW_YLOC_DEFAULT) {
            newYLoc = BOTTOM_VIEW_YLOC_DEFAULT
        }
        bottomViewYLoc.constant = CGFloat(newYLoc)
        // Handle ending state
        if(gestureRecognizer.state == .ended) {
            // Default boolean checks the location of the height, if the velocity is high enough we will use that to determine willBeExpanded
            var willBeExpanded = bottomViewYLoc.constant > (BOTTOM_VIEW_YLOC_EXPANDED - BOTTOM_VIEW_YLOC_DEFAULT) * 0.4 + BOTTOM_VIEW_YLOC_DEFAULT
            if(abs(gestureRecognizer.velocity(in: bottomView.superview).y) > 50) {
                willBeExpanded = gestureRecognizer.velocity(in: bottomView.superview).y < 0
            }
            setBottomViewExpanded(isExpanded: willBeExpanded)
        }
        
    }
 
    func setBottomViewExpanded(isExpanded: Bool) {
        isBottomViewExpanded = isExpanded
        bottomViewYLoc.constant = CGFloat(isBottomViewExpanded ? BOTTOM_VIEW_YLOC_EXPANDED : BOTTOM_VIEW_YLOC_DEFAULT)
        UIView.animate(withDuration: 0.25, delay: 0, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.bottomViewExpandButton.imageView!.image = UIImage(systemName: !self.isBottomViewExpanded ? "chevron.compact.up" : "chevron.compact.down")
            })
        })
    }
 
    private func getDateString() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yy"
        return format.string(from: date)
    }

}

