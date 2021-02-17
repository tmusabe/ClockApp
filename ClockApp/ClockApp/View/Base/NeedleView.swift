//
//  NeedleView.swift
//  ClockApp
//
//  Created by BS-272 on 5/1/21.
//

import Foundation
import SwiftUI

struct NeedleView: View {
    
    let width: CGFloat
    let height: CGFloat
    let color: Color
    let bottomLineHeight: CGFloat?
    
    var body: some View {
        let quarterWidth = self.width / 4
        let halfHeight = self.height / 2
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(self.color)
                .frame(width: quarterWidth, height: halfHeight - (self.width / 2))
            RoundedRectangle(cornerRadius: .infinity)
                .stroke(self.color, lineWidth: quarterWidth)
                .frame(width: self.width, height: self.width)
            if let bottomLineHeight = self.bottomLineHeight {
                Rectangle()
                    .fill(self.color)
                    .frame(width: quarterWidth, height: bottomLineHeight)
            }
            Spacer()
        }
        .frame(width: self.width, height: self.height)
    }
    
}
