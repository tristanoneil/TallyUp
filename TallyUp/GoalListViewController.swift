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
    @IBOutlet weak var addGoalPrompt: UIView!
    @IBOutlet weak var addGoalButton: UIButton!
    @IBOutlet weak var addGoalPromptTopSpace: NSLayoutConstraint!

    @IBOutlet weak var newGoalName: UITextField!
    @IBOutlet weak var newGoalFrequency: UISegmentedControl!
    @IBOutlet weak var newGoalTargetNumber: UITextField!

    var goals: RLMArray!
    var addingGoal = false
    var realm = RLMRealm.defaultRealm()

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
        let goal = goals.objectAtIndex(UInt(indexPath.row)) as Goal

        cell.goalName.text = "\(goal.name) \(goal.frequency)"

        cell.goalCard.layer.masksToBounds = false
        cell.goalCard.layer.shadowColor = UIColor.blackColor().CGColor
        cell.goalCard.layer.shadowOffset = CGSizeMake(0.0, 0.1)
        cell.goalCard.layer.shadowOpacity = 0.1

        return cell
    }

    //
    // Toggles the addGoalPrompt view.
    //
    @IBAction func addGoal(sender: AnyObject) {
        addingGoal ? hideAddGoalPrompt() : showAddGoalPrompt()
    }

    //
    // Saves a new Goal to Realm then hides the addGoalPrompt view.
    //
    @IBAction func saveGoal(sender: AnyObject) {
        if(newGoalName.text.isEmpty) {
            displayValidationError("Goal Name can't be blank.")
            return
        }

        if(newGoalTargetNumber.text.isEmpty) {
            displayValidationError("Target Number can't be blank.")
            return
        }

        let goal = Goal()
        goal.name = newGoalName.text
        goal.frequency = newGoalFrequency.titleForSegmentAtIndex(newGoalFrequency.selectedSegmentIndex)!
        goal.targetNumber = newGoalTargetNumber.text.toInt()!

        realm.transactionWithBlock() {
            self.realm.addObject(goal)
        }

        refreshGoals()
        hideAddGoalPrompt()

        newGoalName.text = ""
        newGoalFrequency.selectedSegmentIndex = 0
        newGoalTargetNumber.text = ""
    }

    private func showAddGoalPrompt() {
        addGoalPromptTopSpace.constant += 170

        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })

        addingGoal = true
        addGoalButton.setTitle("Cancel", forState: UIControlState.Normal)
        newGoalName.becomeFirstResponder()
    }

    private func hideAddGoalPrompt() {
        addGoalPromptTopSpace.constant -= 170

        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })

        addingGoal = false
        addGoalButton.setTitle("Add Goal", forState: UIControlState.Normal)
        newGoalName.resignFirstResponder()
    }

    private func refreshGoals() {
        goals = Goal.allObjects().arraySortedByProperty("createdAt", ascending: false)
        goalsTableView.reloadData()
    }

    private func displayValidationError(message: NSString) {
        let alert = UIAlertView()
        alert.title = "Oh No!"
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
}
