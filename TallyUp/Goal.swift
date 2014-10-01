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

    //
    // Returns the current frequency in UI friendly present tense form.
    //
    func frequencyToPresentTense() -> String {
        switch frequency {
            case "Daily":
                return "Today"
            case "Weekly":
                return "This Week"
            case "Monthly":
                return "This Month"
            default:
                return frequency
        }
    }

    func weekDateRangeForIndex(index: NSInteger) -> DTTimePeriod {
        let currentDate = NSDate()

        let startDate = currentDate
            .dateBySubtractingDays(currentDate.weekday() - 1)
            .dateBySubtractingHours(currentDate.hour())
            .dateBySubtractingMinutes(currentDate.minute())
            .dateBySubtractingSeconds(currentDate.second())

        let endDate = currentDate
            .dateByAddingDays(currentDate.weekday() - 1)
            .dateBySubtractingHours(currentDate.hour())
            .dateBySubtractingMinutes(currentDate.minute())
            .dateBySubtractingSeconds(currentDate.second())

        let dateRange = DTTimePeriod.timePeriodWithStartDate(startDate, endDate: endDate)
        dateRange.shiftEarlierWithSize(DTTimePeriodSize.Week, amount: index)

        return dateRange
    }

    func monthDateRangeForIndex(index: NSInteger) -> DTTimePeriod {
        let currentDate = NSDate()

        let startDate = currentDate
            .dateBySubtractingDays(currentDate.day() - 1)
            .dateBySubtractingHours(currentDate.hour())
            .dateBySubtractingMinutes(currentDate.minute())
            .dateBySubtractingSeconds(currentDate.second())

        let endDate = currentDate
            .dateByAddingDays(currentDate.daysInMonth() - currentDate.day())
            .dateBySubtractingHours(currentDate.hour())
            .dateBySubtractingMinutes(currentDate.minute())
            .dateBySubtractingSeconds(currentDate.second())

        let dateRange = DTTimePeriod.timePeriodWithStartDate(startDate, endDate: endDate)
        dateRange.shiftEarlierWithSize(DTTimePeriodSize.Month, amount: index)

        return dateRange
    }
}
