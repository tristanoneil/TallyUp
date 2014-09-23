//
//  ViewController.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/19/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import UIKit

class GoalsController: UITableViewController {

    var goals = Goal.allObjects()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //
    // Returns the number of rows in the Table View, based on the number of Goals.
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(goals.count)
    }

    //
    // Initializes Table View with Goal instances from Realm.
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GoalCell", forIndexPath: indexPath) as GoalCell
        let goal = goals.objectAtIndex(UInt(indexPath.row)) as Goal

        cell.goalName.text = goal.name

        cell.goalCard.layer.masksToBounds = false
        cell.goalCard.layer.shadowColor = UIColor.blackColor().CGColor
        cell.goalCard.layer.shadowOffset = CGSizeMake(0.0, 0.1)
        cell.goalCard.layer.shadowOpacity = 0.1

        return cell
    }
}
