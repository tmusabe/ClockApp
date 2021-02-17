//
//  Extensions.swift
//  ClockApp
//
//  Created by BS-272 on 16/2/21.
//

import Foundation
import SwiftUI

extension Font {
    static let clockText: Font = .system(size: 25, weight: .regular, design: .default)
    static let lapCellText: Font = .system(size: 15, weight: .regular, design: .default)
    static let lapText: Font = .system(size: 20, weight: .regular, design: .default)
    static let timeText: Font = .custom("courier", size: 50)
    static let locationText: Font = Font.largeTitle.weight(.heavy)
}

extension Color {
    static let backgroundColor = Color.white
    static let clockHighlightedLineColor = Color.black
    static let clockLineColor = Color(red: 71/255, green: 70/255, blue: 74/255)
    static let clockTextColor = Color.black
    static let startButton = Color(red: 103/255, green: 206/255, blue: 102/255)
    static let startButtonText = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let stopButton = Color(red: 235/255, green: 85/255, blue: 69/255)
    static let stopButtonText = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let lapButton = Color(red: 28/255, green: 28/255, blue: 28/255)
    static let lapButtonText = Color(red: 152/255, green: 152/255, blue: 158/255)
    static let lapButtonActive = Color(red: 51/255, green: 51/255, blue: 51/255)
    static let lapButtonActiveText = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let needleNormal = Color(red: 241/255, green: 163/255, blue: 60/255)
    static let needleGeneral = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let needleCurrentLap = Color(red: 158/255, green: 9/255, blue: 6/255)
    static let lapCellSeparator = Color(red: 50/255, green: 50/255, blue: 50/255)
    static let lapCellNormal = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let lapCellBest = Color(red: 183/255, green: 205/255, blue: 183/255)
    static let lapCellWorst = Color(red: 234/255, green: 85/255, blue: 69/255)
    static let actionButtonText = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let saveActionButton = Color(red: 103/255, green: 206/255, blue: 102/255)
    static let cancelActionButton = Color(red: 235/255, green: 85/255, blue: 69/255)
    static let resetActionButton = Color(red: 0/255, green: 80/255, blue: 161/255)
    static let timeText = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let timeTextSelected = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let timeColor = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let timeSelectedColor = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let meridiumColor = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let meridiumText = Color(red: 255/255, green: 255/255, blue: 255/255)
}
