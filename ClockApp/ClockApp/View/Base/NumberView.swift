//
//  NumberView.swift
//  ClockApp
//
//  Created by BS-272 on 4/1/21.
//

import Foundation
import SwiftUI

struct NumberView: View {
    
    let numbers: [Int]
    let textColor: Color
    let font: Font
    
    var body: some View {
        ZStack {
            ForEach(0..<self.numbers.count) { index in
                let degree: Double = Double.pi * 2 / Double(self.numbers.count)
                let itemDegree = degree * Double(index)
                VStack {
                    Text("\(self.numbers[index])")
                        .rotationEffect(.radians(-itemDegree))
                        .foregroundColor(self.textColor)
                        .font(self.font)
                        .foregroundColor(.red)
                    Spacer()
                }
                .rotationEffect(.radians(itemDegree))
            }
        }
    }
    
}
