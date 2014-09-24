//
//  Goal.swift
//  TallyUp
//
//  Created by Tristan O'Neil on 9/23/14.
//  Copyright (c) 2014 Tristan O'Neil. All rights reserved.
//

import Foundation

class Goal: RLMObject {
    dynamic var name = ""
    dynamic var frequency = ""
    dynamic var targetNumber = 0
    dynamic var createdAt = NSDate.date()
}