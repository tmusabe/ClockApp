//
//  AlarmTime.swift
//  ClockApp
//
//  Created by BS-272 on 9/2/21.
//

import Foundation
struct AlarmTime: Identifiable {
    
    let id: String = "alarm"
    var minute: String = ""
    var hour: String = ""
    var meridium: String = ""
    var weekdays : [Bool] = []    
}

