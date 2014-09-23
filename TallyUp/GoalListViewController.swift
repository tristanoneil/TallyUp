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
    @IBOutlet weak var goalsTableViewTopSpace: NSLayoutConstraint!

    var goals = Goal.allObjects()
    var addingGoal = false
    let realm = RLMRealm.defaultRealm()

    override func viewDidLoad() {
        super.viewDidLoad()

        let goal = Goal()
        goal.name = "Goal!!!!"

        realm.transactionWithBlock() {
            self.realm.addObject(goal)
        }

        goals = Goal.allObjects()
        goalsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        cell.goalName.text = goal.name

        cell.goalCard.layer.masksToBounds = false
        cell.goalCard.layer.shadowColor = UIColor.blackColor().CGColor
        cell.goalCard.layer.shadowOffset = CGSizeMake(0.0, 0.1)
        cell.goalCard.layer.shadowOpacity = 0.1

        return cell
    }

    @IBAction func addGoal(sender: AnyObject) {
        if !addingGoal {
            self.goalsTableViewTopSpace.constant += self.addGoalPrompt.frame.height
            addGoalPrompt.hidden = false
            addingGoal = true
        } else {
            self.goalsTableViewTopSpace.constant -= self.addGoalPrompt.frame.height
            addGoalPrompt.hidden = true
            addingGoal = false
        }
    }
}
