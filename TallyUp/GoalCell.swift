//
//  GoalCell.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/23/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

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
    // Toggles TallyUp and TallyDown buttons.
    //
    func expandTallyButtons() {
        if buttonsExpanded {
            tallyUpButtonHeight.constant -= 30
            tallyDownButtonHeight.constant -= 30
        } else {
            tallyUpButtonHeight.constant += 30
            tallyDownButtonHeight.constant += 30
        }

        UIView.animateWithDuration(0.1, animations: {
            self.goalCard.layoutIfNeeded()
        })

        buttonsExpanded = !buttonsExpanded
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
    }
}
