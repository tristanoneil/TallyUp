//
//  Goal.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/23/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

class Goal: RLMObject {
    dynamic var name = ""
    dynamic var frequency = ""
    dynamic var targetNumber = 0
    dynamic var tallies = RLMArray(objectClassName: Tally.className())
    dynamic var createdAt = NSDate.date()

    func frequencyToPresentTense() -> String {
        switch frequency {
            case "Daily":
                return "Today"
            case "Weekly":
                return "This Week"
            default:
                return "This Month"
        }
    }
}
