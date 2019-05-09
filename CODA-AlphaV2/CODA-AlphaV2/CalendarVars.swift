//
//  CalendarVars.swift
//  CODA-AlphaV2
//
//  Created by Samrety Nguon on 5/2/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import Foundation

// Variables for the calendar in appointments page
let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
