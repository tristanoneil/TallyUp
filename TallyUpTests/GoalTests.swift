//
//  TallyUpTests.swift
//  TallyUpTests
//
//  Created by Tristan O'Neil on 9/19/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import UIKit
import XCTest

class GoalTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testfrequencyToPresentTense() {
        let goal = Goal()

        goal.frequency = "Daily"
        XCTAssertEqual("Today", goal.frequencyToPresentTense(), "Present tense of Daily is Today.")

        goal.frequency = "Weekly"
        XCTAssertEqual("This Week", goal.frequencyToPresentTense(), "Present tense of Weekly is This Week.")

        goal.frequency = "Monthly"
        XCTAssertEqual("This Month", goal.frequencyToPresentTense(), "Present tense of Monthly is This Month.")

        goal.frequency = "Yearly"
        XCTAssertEqual(goal.frequency, goal.frequencyToPresentTense(), "Present tense of anything else is the frequency")
    }

    func testWeekDateRangeForIndex() {
        let goal = Goal()

        XCTAssertEqual("\(goal.weekDateRangeForIndex(0).StartDate)", "2014-09-28 04:00:00 +0000", "Start date is correct for an index of 0")
        XCTAssertEqual("\(goal.weekDateRangeForIndex(0).EndDate)", "2014-10-04 04:00:00 +0000", "End date is correct for an index of 0")

        XCTAssertEqual("\(goal.weekDateRangeForIndex(2).StartDate)", "2014-09-14 04:00:00 +0000", "Start date is correct for an index of 2")
        XCTAssertEqual("\(goal.weekDateRangeForIndex(2).EndDate)", "2014-09-20 04:00:00 +0000", "End date is correct for an index of 2")
    }

    func testMonthDateRangeForIndex() {
        let goal = Goal()

        XCTAssertEqual("\(goal.monthDateRangeForIndex(0).StartDate)", "2014-10-01 04:00:00 +0000", "Start date is correct for an index of 0")
        XCTAssertEqual("\(goal.monthDateRangeForIndex(0).EndDate)", "2014-10-31 04:00:00 +0000", "End date is correct for an index of 0")

        XCTAssertEqual("\(goal.monthDateRangeForIndex(1).StartDate)", "2014-09-01 04:00:00 +0000", "Start date is correct for an index of 2")
        XCTAssertEqual("\(goal.monthDateRangeForIndex(1).EndDate)", "2014-09-30 04:00:00 +0000", "End date is correct for an index of 2")
    }
}
