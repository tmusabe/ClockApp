//
//  RoundRectangleButtonStyle.swift
//  ClockApp
//
//  Created by BS-272 on 16/2/21.
//

import Foundation
import SwiftUI

struct RoundRectangleButtonStyle: ButtonStyle {
    
    let textColor: Color
    let backgroundColor: Color
    let conrnerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: self.conrnerRadius)
                    .stroke(self.backgroundColor, lineWidth: 10)
            )
            .background(self.backgroundColor)
            .foregroundColor(self.textColor)
    }
}
