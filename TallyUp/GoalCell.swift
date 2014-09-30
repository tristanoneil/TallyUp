//
//  GoalCell.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/23/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell, JBBarChartViewDataSource, JBBarChartViewDelegate {

    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var goalCard: UIView!
    @IBOutlet weak var goalTally: UILabel!
    @IBOutlet weak var goalTargetNumber: UILabel!
    @IBOutlet weak var goalFrequency: UILabel!
    @IBOutlet weak var tallyDownButton: UIButton!
    @IBOutlet weak var tallyUpButton: UIButton!
    @IBOutlet weak var tallyUpButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var tallyDownButtonHeight: NSLayoutConstraint!

    var goal: Goal!
    var goalListViewController: GoalListViewController!
    var realm = RLMRealm.defaultRealm()
    var buttonsExpanded = false

    //
    // Adds a new Tally to the goal and refreshes the parent GoalListViewController.
    //
    @IBAction func tallyUp(sender: AnyObject) {
        realm.transactionWithBlock() {
            self.goal.tallies.addObject(Tally())
        }

        goalListViewController.refreshGoals()
    }

    //
    // Removes the last Tally and refreshes the parent GoalListViewController.
    //
    @IBAction func tallyDown(sender: AnyObject) {
        realm.transactionWithBlock() {
            self.goal.tallies.removeLastObject()
        }

        goalListViewController.refreshGoals()
    }

    //
    // Toggles TallyUp and TallyDown buttons for the Goal that gets touched.
    // Untoggles all other Goal TallyUp and TallyDown buttons.
    //
    func expandTallyButtons() {
        for subview in superview?.subviews as [AnyObject]! {
            var cell = subview as GoalCell

            if self == cell && !self.buttonsExpanded {
                cell.tallyDownButtonHeight.constant = 30
                cell.tallyUpButtonHeight.constant = 30
                cell.buttonsExpanded = true
            } else {
                cell.tallyDownButtonHeight.constant = 0
                cell.tallyUpButtonHeight.constant = 0
                cell.buttonsExpanded = false
            }
        }

        UIView.animateWithDuration(0.1, animations: {
            self.goalCard.layoutIfNeeded()
        })
    }

    //
    // Sets up the UI elements of the cell and draws the cells shadow.
    //
    func setupCell() {
        goalName.text = goal.name
        goalTally.text = String(goal.tallies.count)
        goalTargetNumber.text = "of \(goal.targetNumber)"
        goalFrequency.text = goal.frequencyToPresentTense()

        goalCard.layer.masksToBounds = false
        goalCard.layer.shadowColor = UIColor.blackColor().CGColor
        goalCard.layer.shadowOffset = CGSizeMake(0.0, 0.1)
        goalCard.layer.shadowOpacity = 0.1

        var touch = UITapGestureRecognizer(target: self, action: "expandTallyButtons")
        goalCard.addGestureRecognizer(touch)

        tallyUpButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03).CGColor
        tallyUpButton.layer.borderWidth = 1

        tallyDownButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03).CGColor
        tallyDownButton.layer.borderWidth = 1

        let barChart = JBBarChartView()
        barChart.dataSource = self
        barChart.delegate = self
        barChart.frame = CGRectMake(0, 100, 150, 50)
        goalCard.addSubview(barChart)
        goalCard.sendSubviewToBack(barChart)
        barChart.reloadData()
    }

    //
    // Return the number of bars in the chart.
    //
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return 8
    }

    //
    // Return each data point for each bar in the chart.
    //
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        return CGFloat(arc4random() % 20)
    }

    //
    // Return the color for each bar in the chart.
    //
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        return UIColor(red: 0.902, green: 0.937, blue: 0.957, alpha: 1)
    }
}
