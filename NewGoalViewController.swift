//
//  NewGoalViewController.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/25/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import UIKIT

class NewGoalViewController: UIViewController {

    @IBOutlet weak var goalName: UITextField!
    @IBOutlet weak var goalFrequency: UISegmentedControl!
    @IBOutlet weak var goalTargetNumber: UITextField!

    var realm = RLMRealm.defaultRealm()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //
    // Saves a new Goal to Realm then hides the addGoalPrompt view.
    //
    @IBAction func saveGoal(sender: AnyObject) {
        if(goalName.text.isEmpty) {
            displayValidationError("Goal Name can't be blank.")
            return
        }

        if(goalTargetNumber.text.isEmpty) {
            displayValidationError("Target Number can't be blank.")
            return
        }

        let goal = Goal()
        goal.name = goalName.text
        goal.frequency = goalFrequency.titleForSegmentAtIndex(goalFrequency.selectedSegmentIndex)!
        goal.targetNumber = goalTargetNumber.text.toInt()!

        realm.transactionWithBlock() {
            self.realm.addObject(goal)
        }

        let goalListViewController = parentViewController as GoalListViewController
        goalListViewController.hideAddGoalPrompt()
        goalListViewController.refreshGoals()

        goalName.text = ""
        goalFrequency.selectedSegmentIndex = 0
        goalTargetNumber.text = ""
    }

    private func displayValidationError(message: NSString) {
        let alert = UIAlertView()
        alert.title = "Oh No!"
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
}
