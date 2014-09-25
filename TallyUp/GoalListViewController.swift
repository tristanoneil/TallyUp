//
//  GoalListViewController.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/23/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import UIKit

class GoalListViewController: UIViewController {

    @IBOutlet weak var goalsTableView: UITableView!
    @IBOutlet weak var addGoalButton: UIButton!
    @IBOutlet weak var addGoalPane: UIView!
    @IBOutlet weak var addGoalPaneSpacing: NSLayoutConstraint!

    var goals: RLMArray!
    var addingGoal = false

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        // Load all goals ordered by creation date.
        //
        refreshGoals()

        //
        // Set table view insets to there is padding at the top and bottom.
        //
        goalsTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
    }

    //
    // Returns the number of rows in the Table View, based on the number of Goals.
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(goals.count)
    }

    //
    // Initializes Table View with Goal instances from Realm.
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GoalCell", forIndexPath: indexPath) as GoalCell

        cell.goal = goals.objectAtIndex(UInt(indexPath.row)) as Goal
        cell.goalListViewController = self
        cell.setupCell()

        return cell
    }

    //
    // Toggles the add goal pane and changes the navigation button text.
    //
    @IBAction func toggleGoalPane(sender: AnyObject) {
        if addingGoal {
            addGoalPaneSpacing.constant -= addGoalPane.frame.height
            addGoalButton.setTitle("Add Goal", forState: UIControlState.Normal)
        } else {
            addGoalPaneSpacing.constant += addGoalPane.frame.height
            addGoalButton.setTitle("Cancel", forState: UIControlState.Normal)
        }

        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })

        addingGoal = !addingGoal
    }

    //
    // Fetches the goals from realm and reloads the table view data.
    //
    func refreshGoals() {
        goals = Goal.allObjects().arraySortedByProperty("createdAt", ascending: false)
        goalsTableView.reloadData()
    }
}
