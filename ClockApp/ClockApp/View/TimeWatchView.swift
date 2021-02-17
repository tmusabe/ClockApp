//
//  TimeWatchView.swift
//  ClockApp
//
//  Created by BS-272 on 16/2/21.
//

import SwiftUI

struct TimeWatchView: View {
        
    @State var current_Time = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            GeometryReader { geometryReader in
                VStack{
                    ZStack {
                        let width = geometryReader.size.width - Constraint.marginLeading - Constraint.marginTrailing
                        ClockView(count: 60, longDivider: 5, longTickHeight: Constraint.longTickHeight, tickHeight: Constraint.tickHeight, tickWidth: Constraint.tickWidth, highlightedColorDivider: 20, highlightedColor: .clockHighlightedLineColor, normalColor: .clockLineColor)
                            .frame(width: width, height: width)
                        
                        let numberWidth = width - Constraint.numberPadding
                        NumberView(numbers: self.getNumbers(count: 12), textColor: .clockTextColor, font: .clockText)
                            .frame(width: numberWidth, height: numberWidth)
                        
                        NeedleView(width: Constraint.needleViewWidth, height: numberWidth * 0.5, color: .needleGeneral, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                            .rotationEffect(.degrees((Double(current_Time.hour) + Double(current_Time.min) / 60)) * 30)
                        
                        NeedleView(width: Constraint.needleViewWidth, height: numberWidth * 0.75, color: .needleGeneral, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                            .rotationEffect(.degrees(Double(current_Time.min)*6))
                        
                        NeedleView(width: Constraint.needleViewWidth, height: numberWidth-10, color: .needleGeneral, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                            .rotationEffect(.degrees(Double(current_Time.sec)*6))
                    }
                    .padding(.leading, Constraint.marginLeading)
                    .padding(.trailing, Constraint.marginTrailing)
                    .padding(.top, Constraint.marginTop)
                    
                    Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "")
                        .font(.locationText)
                        .padding(.top,35)
                    
                    Text(getTime())
                        .font(.timeText)
                        .padding(.top,10)
                    
                    Spacer(minLength: 0)
                
                }
                .onAppear {
                    let calender = Calendar.current
                    
                    let min = calender.component(.minute, from: Date())
                    let sec = calender.component(.second, from: Date())
                    let hour = calender.component(.hour, from: Date())
                    
                    withAnimation(Animation.linear(duration: 0.01)) {
                        self.current_Time = Time(min: min, sec: sec, hour: hour)
                    }
                }
                .onReceive(receiver) { (_) in
                    let calender = Calendar.current
                    
                    let min = calender.component(.minute, from: Date())
                    let sec = calender.component(.second, from: Date())
                    let hour = calender.component(.hour, from: Date())
                    
                    withAnimation(Animation.linear(duration: 0.01)) {
                        self.current_Time = Time(min: min, sec: sec, hour: hour)
                    }
                }
            }
        }
    }
    
    private func getNumbers(count: Int) -> [Int] {
        var numbers: [Int] = []
        numbers.append(count)
        for index in 1..<count {
            numbers.append(index)
        }
        return numbers
    }
    
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm:ss a"
        
        return format.string(from: Date())
    }

}

struct TimeWatchView_Previews: PreviewProvider {
    static var previews: some View {
        TimeWatchView()
    }
}
