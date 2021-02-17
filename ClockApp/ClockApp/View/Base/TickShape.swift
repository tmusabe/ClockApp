//
//  TickShape.swift
//  ClockApp
//
//  Created by BS-272 on 4/1/21.
//

import Foundation
import SwiftUI

struct TickShape: Shape {
    
    let tickHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + self.tickHeight))
        return path
    }
    
}
