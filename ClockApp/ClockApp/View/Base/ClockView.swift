//
//  ClockView.swift
//  ClockApp
//
//  Created by BS-272 on 4/1/21.
//

import Foundation
import SwiftUI

struct ClockView: View {
    
    let count: Int
    let longDivider: Int
    let longTickHeight: CGFloat
    let tickHeight: CGFloat
    let tickWidth: CGFloat
    let highlightedColorDivider: Int
    let highlightedColor: Color
    let normalColor: Color
    
    var body: some View {
        ZStack {
            ForEach(0..<self.count) { index in
                let height = (index % self.longDivider == 0) ? self.longTickHeight : self.tickHeight
                let color = (index % self.highlightedColorDivider == 0) ? self.highlightedColor : self.normalColor
                let degree: Double = Double.pi * 2 / Double(self.count)
                TickShape(tickHeight: height)
                    .stroke(lineWidth: self.tickWidth)
                    .rotationEffect(.radians(degree * Double(index)))
                    .foregroundColor(color)
            }
        }
    }
    
}
