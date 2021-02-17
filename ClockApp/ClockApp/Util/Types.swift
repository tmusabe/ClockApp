//
//  Types.swift
//  ClockApp
//
//  Created by BS-272 on 16/2/21.
//

import Foundation

enum NeedleType {
    case minute
    case hour
    case none
}

enum LeftButtonType {
    case lapPassive
    case lapActive
    case reset
    case cancel
}

enum LapType {
    case normal
    case best
    case worst
}
