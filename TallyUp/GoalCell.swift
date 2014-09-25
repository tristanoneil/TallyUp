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

    var goal: Goal!
    var goalListViewController: GoalListViewController!
    var realm = RLMRealm.defaultRealm()

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
    }
}
