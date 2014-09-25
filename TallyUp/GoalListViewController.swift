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

    @IBOutlet weak var newGoalName: UITextField!
    @IBOutlet weak var newGoalFrequency: UISegmentedControl!
    @IBOutlet weak var newGoalTargetNumber: UITextField!

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    // Toggles the addGoalPrompt view.
    //
    @IBAction func addGoal(sender: AnyObject) {
        addingGoal ? hideAddGoalPrompt() : showAddGoalPrompt()
    }

    //
    // Slides up the goal prompt and changes the navigation button text to Add Goal.
    //
    func hideAddGoalPrompt() {
        addGoalPaneSpacing.constant -= addGoalPane.frame.height

        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })

        addingGoal = false
        addGoalButton.setTitle("Add Goal", forState: UIControlState.Normal)
    }

    //
    // Fetches the goals from realm and reloads the table view data.
    //
    func refreshGoals() {
        goals = Goal.allObjects().arraySortedByProperty("createdAt", ascending: false)
        goalsTableView.reloadData()
    }

    private func showAddGoalPrompt() {
        addGoalPaneSpacing.constant += addGoalPane.frame.height

        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })

        addingGoal = true
        addGoalButton.setTitle("Cancel", forState: UIControlState.Normal)
    }
}
