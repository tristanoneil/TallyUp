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
}
